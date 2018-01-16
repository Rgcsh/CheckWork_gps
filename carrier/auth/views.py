# -*- coding:utf-8 -*-
import datetime
import hashlib
import json
import os
import random
import sys
import time

import requests
import xlwt
from flask import request, jsonify, g, send_from_directory, url_for, redirect, \
    current_app

import carrier.constant as cs
from carrier import db, redis_store
from carrier.auth import auth
from carrier.models import User, Check_work
from carrier.service.decorator import request_info, v_login, v_normal_role, v_manager_role
from carrier.service.public_service import gen_two_password, gen_random_password, \
    try_check_request_data, gen_one_password, v_file, distance, set_style, get_date_list, \
    get_today_date, get_today_time, change_email_str, is_none
from carrier.service.public_service import request_data, db_commit_all, sm
from carrier.service.public_service import resq_wrapper as rw

reload(sys)
sys.setdefaultencoding('utf-8')

__version__ = '0.1'
__author__ = 'RGC'
__date__ = '2017-11-07'

SESSION = db.session


@auth.before_request
def before_request():
    if request.path == '/carrier/export':
        token = request.values.get('token')
    else:
        token = request_data().get('token')
    if token:
        get_token = redis_store.hgetall('token:%s' % token)
        if get_token:
            email = get_token['email']
            user_obj = User.query.filter_by(email=email).first()
            g.user = user_obj
            redis_store.expire('token:%s' % token, current_app.config['TOKEN_EXPIRE'])
        else:
            return rw(cs.TOKEN_EXPIRE)
    return


@auth.teardown_request
def handle_teardown_request(ex):
    SESSION.remove()


@auth.route('/')
@request_info
def index():
    return redirect(url_for('.index', _external=True) + current_app.config['FRONT_URL'] + 'index.html')


# User actions
# ============

@auth.route('/carrier/users', methods=['POST'])
@request_info
def register():
    '''
        注册接口
        password,str:must
        email,str:must
        role_type,int:must
        username,str:must
    '''
    request_dict = try_check_request_data(request_data(), ['password', 1, 1], ['email', 1, 1],
                                          ['role_type', 0, 1], ['username', 1, 1])
    try:
        password = gen_one_password(request_dict['password'])
        email = request_dict['email']
        role_type = request_dict['role_type']
        username = request_dict['username']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    u = User(password=password, email=email, role_type=role_type, username=username)
    user = SESSION.query(User.id).filter_by(email=u.email).first()
    if user:
        return rw(cs.REGISTERED)
    if role_type == 2:
        search_info = {'ak': current_app.config['BAIDU_KEY'],
                       'service_id': 136114,
                       'entity_name': change_email_str(email),
                       'entity_desc': username
                       }
        try:
            r = requests.post(current_app.config['BAIDU_URL'] + '/entity/add', data=search_info)
            print r.text
            if json.loads(r.text)['status'] != 0:
                return rw(cs.BD_ADD_ENTITY_ERROR, r.text)
        except:
            return rw(cs.BD_ADD_ENTITY_ERROR, r.text)
    return db_commit_all([u], [request, '承运商用户注册接口', '注册时没有user.id'])


@auth.route('/carrier/user_delete', methods=['POST'])
@request_info
def user_delete():
    '''
        delete接口
        entity_name,str:must
    '''
    request_dict = try_check_request_data(request_data(), ['entity_name', 1, 1])
    try:
        entity_name = gen_two_password(request_dict['entity_name'])
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    search_info = {'ak': current_app.config['BAIDU_KEY'],
                   'service_id': 136114,
                   'entity_name': change_email_str(entity_name)
                   }
    r = requests.post(current_app.config['BAIDU_URL'] + '/entity/delete', data=search_info)
    if json.loads(r.text)['status'] != 0:
        return rw(cs.BD_ADD_ENTITY_ERROR, r.text)
    return rw(cs.OK)


@auth.route('/carrier/login', methods=['POST'])
@request_info
def login():
    '''
        登录接口
        email,str:must
        password,str:must
    '''
    request_dict = try_check_request_data(request_data(), ['password', 1, 1], ['email', 1, 1])
    try:
        password = gen_one_password(request_dict['password'])
        email = request_dict['email']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    user = User.query.filter_by(email=email).first()
    if not user:
        return rw(cs.NO_USER)
    if user.password != password:
        return rw(cs.PASSWD_ERR)

    m = hashlib.md5()
    m.update(email)
    m.update(password)
    m.update(str(int(time.time())))
    token = m.hexdigest()

    user_json = user.to_dict()
    user_json.update({'token': token})
    redis_store.hmset('token:%s' % token, user_json)
    redis_store.expire('token:%s' % token, current_app.config['TOKEN_EXPIRE'])
    return rw(cs.OK, user_json)


@auth.route('/carrier/logout')
@request_info
@v_login
def logout():
    '''
        退出接口
        token,str:must
    '''
    token = request_data().get('token')
    redis_store.delete('token:%s' % token)
    return jsonify({'code': 1800, 'message': 'logout success'})


@auth.route('/carrier/passwd', methods=['POST'])
@request_info
@v_login
def password_reset():
    '''
    重置密码接口
    new_password,str:must
    old_password,str:must
    '''
    user = g.user
    request_dict = try_check_request_data(request_data(), ['new_password', 1, 0], ['old_password', 1, 0],
                                          ['user_no', 1, 0], ['user_department', 1, 0])
    try:
        new_password = request_dict['new_password']
        old_password = request_dict['old_password']
        user_no = request_dict['user_no']
        user_department = request_dict['user_department']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    judge_user_no_obj = User.query.filter_by(user_no=user_no).first()
    if judge_user_no_obj and judge_user_no_obj.id != user.id:
        return rw(cs.REGISTERED)
    userobj = User.query.filter_by(id=user.id).first()
    if not userobj:
        return rw(cs.LOGIN_FAIL)
    # 判断是否修改密码
    if new_password != '' and old_password != '':
        old_password = gen_one_password(old_password)
        new_password = gen_one_password(new_password)
        if userobj.password == new_password:
            return rw(cs.PARAMS_ERR)
        if old_password != userobj.password:
            return rw(cs.PASSWD_ERR)
        userobj.password = new_password
    userobj.update_time = datetime.datetime.now()
    userobj.user_no = user_no
    userobj.user_department = user_department
    return db_commit_all([userobj], [request, '修改密码接口', user.id])


@auth.route('/carrier/password', methods=['POST'])
@request_info
def password_send():
    '''
    忘记密码接口
    email:must have
    '''

    email = request_data().get('email')
    user = User.query.filter_by(email=email).first()
    if user:
        password = gen_random_password()
        passwd = gen_two_password(password)
        user.password = passwd
        sm(user.email, password)
        SESSION.commit()
        return rw(cs.OK)
    else:
        return rw(cs.NO_USER)


@auth.route('/carrier/uploader', methods=['POST'])
@request_info
@v_login
def uploader():
    '''
    图片上传接口
    '''
    user = g.user
    user_id = str(user.id)
    file_upload = request.files['file']
    if file_upload and v_file(file_upload.filename):
        flag = request_data().get('flag')
        timestamp = str(time.time()).replace(".", "")
        postfName = str(file_upload.filename.rsplit('.', 1)[1].lower())
        savename = user_id + '_' + flag + '_' + timestamp + '.' + postfName
        file_upload.save(os.path.join(current_app.config['UPLOAD_FOLDER'], savename))
        url = url_for('.index', _external=True) + current_app.config['UPLOAD_FOLDER'] + savename
        return rw(cs.OK, url)
    else:
        return rw(cs.PARAMS_ERR)


@auth.route('/upload/<path:path>')
@request_info
def send_file(path):
    '''
    获取图片
    '''
    return send_from_directory('upload/', path)


@auth.route('/fence/createcirclefence', methods=['POST'])
@request_info
@v_login
@v_manager_role
def createcirclefence():
    '''
    创建圆形围栏
    fence_name:NOT MUST, 围栏名称
    longitude:must have,围栏圆心经度
    latitude:must have,围栏圆心纬度
    radius:must have,围栏半径
    '''
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    request_dict = try_check_request_data(request_data(), ['longitude', 3, 1]
                                          , ['latitude', 3, 1], ['radius', 0, 1])
    try:
        longitude = request_dict['longitude']
        latitude = request_dict['latitude']
        radius = request_dict['radius']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    search_info = {
        'monitored_person': '#allentity',
        'longitude': longitude,
        'latitude': latitude,
        'radius': radius,
        'coord_type': 'bd09ll',
        'denoise': 0
    }
    dict_input = dict(search_info.items() + current_app.config['BAIDU_ALLOW_JSON'].items())
    r = requests.post(current_app.config['BAIDU_URL'] + '/fence/createcirclefence', data=dict_input)
    if json.loads(r.text)['status'] != 0:
        return rw(cs.BD_ADD_FENCE_ERROR, r.text)
    return rw(cs.OK, r.text)


@auth.route('/fence/updatecirclefence', methods=['POST'])
@request_info
@v_login
@v_manager_role
def updatecirclefence():
    '''
    更新圆形围栏
    fence_id:MUST, 围栏的唯一标识
    fence_name:NOT MUST, 围栏名称
    longitude:must have,围栏圆心经度
    latitude:must have,围栏圆心纬度
    radius:must have,围栏半径
    denoise:must have,围栏去噪参数
    '''
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    request_dict = try_check_request_data(request_data(), ['fence_id', 0, 1], ['longitude', 3, 1]
                                          , ['latitude', 3, 1], ['radius', 0, 1])
    try:
        fence_id = request_dict['fence_id']
        longitude = request_dict['longitude']
        latitude = request_dict['latitude']
        radius = request_dict['radius']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    search_info = {
        'fence_id': fence_id,
        'monitored_person': '#allentity',
        'longitude': longitude,
        'latitude': latitude,
        'radius': radius,
        'coord_type': 'bd09ll',
        'denoise': 0
    }
    dict_input = dict(search_info.items() + current_app.config['BAIDU_ALLOW_JSON'].items())
    r = requests.post(current_app.config['BAIDU_URL'] + '/fence/updatecirclefence', data=dict_input)
    if json.loads(r.text)['status'] != 0:
        return rw(cs.BD_UPDATE_FENCE_ERROR, r.text)
    return rw(cs.OK, r.text)


@auth.route('/fence/list', methods=['GET'])
@request_info
@v_login
# @v_manager_role
def fence_list():
    '''
    查询围栏
    '''
    search_info = {
        'fence_ids': '4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20'
    }
    dict_input = dict(search_info.items() + current_app.config['BAIDU_ALLOW_JSON'].items())
    r = requests.get(current_app.config['BAIDU_URL'] + '/fence/list', params=dict_input)
    return_message = json.loads(r.text)
    if return_message['status'] != 0:
        return rw(cs.BD_QUERY_FENCE_ERROR, r.text)
    if int(return_message['size']) == 0:
        return rw(cs.EMPTY_FENCE)
    else:
        fence_id = return_message['fences'][0]['fence_id']
        longitude = return_message['fences'][0]['longitude']
        latitude = return_message['fences'][0]['latitude']
        radius = return_message['fences'][0]['radius']
        return rw(cs.OK, {'fence_id': fence_id, 'longitude': longitude, 'latitude': latitude, 'radius': radius})


@auth.route('/fence/delete', methods=['POST'])
@request_info
def fence_delete():
    '''
    delete围栏
    '''
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    request_dict = try_check_request_data(request_data(), ['fence_ids', 0, 1])
    try:
        fence_ids = request_dict['fence_ids']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    search_info = {
        'fence_ids': fence_ids
    }
    dict_input = dict(search_info.items() + current_app.config['BAIDU_ALLOW_JSON'].items())
    r = requests.post(current_app.config['BAIDU_URL'] + '/fence/delete', data=dict_input)
    if json.loads(r.text)['status'] != 0:
        return rw(cs.BD_UPDATE_FENCE_ERROR, r.text)
    return rw(cs.OK, r.text)


@auth.route('/fence/querystatus', methods=['POST'])
@request_info
@v_login
@v_normal_role
def fence_querystatus():
    '''
    打卡,查询是否在围栏内
    onwork:must,1:上班 2:下班
    '''

    request_dict = try_check_request_data(request_data(), ['onwork', 0, 1], ['fence_id', 0, 1])
    try:
        onwork = request_dict['onwork']
        fence_ids = request_dict['fence_id']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    search_info = {
        'entity_name': change_email_str(g.user.email)
    }
    dict_input = dict(search_info.items() + current_app.config['BAIDU_ALLOW_JSON'].items())
    # user
    r = requests.get(current_app.config['BAIDU_URL'] + '/track/getlatestpoint', params=dict_input)
    if json.loads(r.text)['status'] != 0:
        return rw(cs.BD_GETLAST_POINT_FAIL, r.text)
    user_lon = json.loads(r.text)['latest_point']['longitude']
    user_lat = json.loads(r.text)['latest_point']['latitude']
    # 围栏
    dict_fence = {'fence_ids': fence_ids}
    dict_fence_input = dict(dict_fence.items() + current_app.config['BAIDU_ALLOW_JSON'].items())
    r_fence = requests.get(current_app.config['BAIDU_URL'] + '/fence/list', params=dict_fence_input)
    if json.loads(r_fence.text)['status'] != 0:
        return rw(cs.BD_QUERY_FENCE_ERROR, r_fence.text)

    fence_lon = json.loads(r_fence.text)['fences'][0]['longitude']
    fence_lat = json.loads(r_fence.text)['fences'][0]['latitude']
    fence_radius = json.loads(r_fence.text)['fences'][0]['radius']
    # 计算是否在围栏内
    true_distance = distance(user_lon, user_lat, fence_lon, fence_lat)
    # print true_distance
    # print fence_radius
    # print onwork
    if true_distance < fence_radius:
        this_date = get_today_date()
        this_time = get_today_time()
        check_user_exist_obj = Check_work.query.filter_by(user_id=g.user.id, date=this_date).first()
        if check_user_exist_obj:
            if check_user_exist_obj.end_time is not None and check_user_exist_obj.start_time is not None:
                return rw(cs.HAVEN_COLOCK)
            elif check_user_exist_obj.end_time is None and check_user_exist_obj.start_time is not None and onwork == 2:
                check_user_exist_obj.end_time = this_time
            elif check_user_exist_obj.end_time is not None and check_user_exist_obj.start_time is None and onwork == 1:
                return rw(cs.PASTED_MORNNING_COLOCK)
            elif check_user_exist_obj.start_time and onwork == 1:
                return rw(cs.HAVEN_COLOCK)
            elif check_user_exist_obj.end_time and onwork == 2:
                return rw(cs.HAVEN_COLOCK)
            else:
                return rw(cs.CAN_NOT_CLOCK, '无法打卡!')
        else:
            check_user_exist_obj = Check_work(this_date, g.user.id)
            if onwork == 1:
                check_user_exist_obj.start_time = this_time
            elif onwork == 2:
                check_user_exist_obj.end_time = this_time
            else:
                return rw(cs.CAN_NOT_CLOCK, '无法打卡!!')
        # 成功打卡
        return db_commit_all([check_user_exist_obj], [request, '打卡接口', g.user.id])
    # 打卡失败,不再围栏内
    return rw(cs.OUT_FENCE)


@auth.route('/carrier/up_map', methods=['POST'])
@request_info
@v_login
@v_normal_role
def update():
    '''
    上传经纬度坐标
    lat:must have, 纬度
    lon:must have, 经度
    '''
    request_dict = try_check_request_data(request_data(), ['latitude', 3, 1], ['longitude', 3, 1])
    try:
        lat = request_dict['latitude']
        lon = request_dict['longitude']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    search_info = {'ak': current_app.config['BAIDU_KEY'],
                   'service_id': 136114,
                   'coord_type_input': 'wgs84',
                   'entity_name': change_email_str(g.user.email),
                   'latitude': lat,
                   'longitude': lon,
                   'radius': 1,
                   'loc_time': int(time.time())
                   }
    r = requests.post(current_app.config['BAIDU_URL'] + '/track/addpoint', data=search_info)
    return rw(cs.OK, r.text)


@auth.route('/carrier/geoconv', methods=['GET'])
@request_info
@v_login
@v_normal_role
def geoconv():
    '''
    坐标转换
    lat:must have, 纬度
    lon:must have, 经度
    '''
    request_dict = try_check_request_data(request_data(), ['lat', 3, 1], ['lng', 3, 1])
    try:
        lat = request_dict['lat']
        lon = request_dict['lng']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)

    search_info = {'ak': current_app.config['BAIDU_KEY'],
                   'coords': '%s,%s' % (lon, lat),
                   'from': 1,
                   'to': 5}
    r = requests.get('http://api.map.baidu.com/geoconv/v1/', params=search_info)
    return_text = json.loads(r.text)
    if return_text['status'] != 0:
        return rw(cs.TRANS_POINT_FAIL)
    lon = return_text['result'][0]['x']
    lat = return_text['result'][0]['y']
    return rw(cs.OK, {'lon': lon, 'lat': lat})


@auth.route('/carrier/export', methods=['GET'])
@v_login
@request_info
def send_excel():
    """
    print shippers' information
    """
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    request_dict = try_check_request_data(request_data(), ['name', 1, 0],  ['user_id', 1, 0], ['num', 1, 0], ['depart', 1, 0],
                                          ['email', 1, 0], ['start_date', 1, 1], ['end_date', 1, 1])
    try:
        name = request_dict['name']
        user_id = request_dict['user_id']
        num = request_dict['num']
        depart = request_dict['depart']
        email = request_dict['email']
        start_date = request_dict['start_date']
        end_date = request_dict['end_date']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    query_str = 'user.role_type=2 '
    print 'df', name,depart,num,email,user_id
    if name!='':
        query_str += 'and user.username="%s" ' % (name)
    if depart!='':
        query_str += 'and user.user_department="%s" ' % (depart)
    if num!='':
        query_str += 'and user.user_no="%s" ' % (num)
    if email!='':
        query_str += 'and user.email="%s" ' % (email)
    if user_id!='':
        query_str += 'and user.id="%s" ' % (user_id)
    user_list = User.query.filter(query_str).all()
    print query_str
    if len(user_list)==0:
        return rw(cs.NO_DATA)

    date_list = get_date_list(start_date, end_date)
    # 创建工作簿
    f = xlwt.Workbook()
    for item in user_list:
        user_name = item.username
        user_department = item.user_department
        user_no = item.user_no
        email = item.email
        # 创建表格
        sheet1 = f.add_sheet(user_name, cell_overwrite_ok=True)
        # 第一行
        sheet1.write_merge(0, 0, 0, 3, u'员工考勤表', set_style(u'正楷', 350, True))
        # 第二行
        row_two = [u'姓名', u'部门', u'工号', u'邮箱']
        for i in range(0, len(row_two)):
            sheet1.write(1, i, row_two[i], set_style('Times New Roman', 250, False))
        # 第三行
        row_three = [user_name, user_department, user_no, email]
        for i in range(0, len(row_three)):
            sheet1.write(2, i, row_three[i], set_style('Times New Roman', 250, False))

        # 第五行
        row_five = [u'日期', u'上班时间', u'下班时间', u'备注']
        for i in range(0, len(row_five)):
            sheet1.write(4, i, row_five[i], set_style('Times New Roman', 250, False))
        # 其他行
        row = 4
        for date_item in date_list:
            user_work = Check_work.query.filter_by(date=date_item, user_id=item.id).first()
            if user_work:
                row += 1
                sheet1.write(row, 0, date_item, set_style('Times New Roman', 250, False))
                sheet1.write(row, 1, user_work.start_time, set_style('Times New Roman', 250, False))
                sheet1.write(row, 2, user_work.end_time, set_style('Times New Roman', 250, False))
        # 设置列宽
        for cols_item in range(5):
            first_col = sheet1.col(cols_item)
            first_col.width = 256 * 23
    filename = '员工考勤表_%s至%s_%s%s' % (start_date, end_date,time.time(),random.random()) + '.xls'
    f.save('upload/' + filename)
    excel_url = url_for('.index', _external=True) + 'upload/' + filename
    return rw(cs.OK, excel_url)


@auth.route('/carrier/user_list', methods=['GET'])
@request_info
@v_login
@v_manager_role
def carrier_user_list():
    """
    print shippers' information
    """
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    request_dict = try_check_request_data(request_data(), ['name', 1, 0], ['depart', 1, 0], ['num', 1, 0],
                                          ['email', 1, 0], ['page_index', 0, 1])
    try:
        name = request_dict['name']
        depart = request_dict['depart']
        num = request_dict['num']
        email = request_dict['email']
        page_index = request_dict['page_index']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)

    query_str='user.role_type=2 '
    if name!='':
        query_str+='and user.username="%s" ' %(name)
    if depart!='':
        query_str+='and user.user_department="%s" ' %(depart)
    if num!='':
        query_str+='and user.user_no="%s" ' %(num)
    if email!='':
        query_str+='and user.email="%s" ' %(email)
    query_result= db.session.query(User.username, User.user_department, User.user_no, User.email, User.id).filter(
        query_str
    )
    count = query_result.count()
    truck_objs = query_result.order_by().slice((page_index - 1) * 15,page_index * 15)
    data = [{'check_result_name': item[0], 'check_result_depart': is_none(item[1]), 'check_result_num': is_none(item[2]),
             'check_result_email': item[3],'user_id': item[4]} for item in truck_objs]
    if count != 0:
        return jsonify({'code': 1800, 'data': data, 'count': count, 'errmsg': None})
    else:
        return jsonify({'code': 1808, 'errmsg': cs.ERR_MSG[1808], 'data': None})
    return rw(cs.OK)


@auth.route('/carrier/check_work_detail', methods=['GET'])
@request_info
@v_login
def check_work_detail():
    """
    print shippers' information
    """
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    request_dict = try_check_request_data(request_data(), ['user_no', 1, 1], ['start_time', 1, 1], ['end_time', 1, 1])
    try:
        user_id = request_dict['user_no']
        start_date = request_dict['start_time']
        end_date = request_dict['end_time']
    except:
        return rw(cs.REQUEST_GET_VAL_fAIL)
    result_list_obj=Check_work.query.filter(Check_work.user_id==user_id,Check_work.date.between(start_date, end_date))
    print result_list_obj
    count=result_list_obj.count()

    if count==0:
        return rw(cs.NO_DATA)
    result_list=[]
    for item in result_list_obj:
        result_list.append({'date':item.date,'start_time':is_none(item.start_time),'end_time':is_none(item.end_time)})
    return rw(cs.OK,result_list)






