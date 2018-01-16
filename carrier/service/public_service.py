# -*- coding: utf-8 -*-
import hashlib
import json
import smtplib
import datetime
import string
import math
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.header import Header
from random import choice

import os

import re
import xlwt
from flask import current_app, url_for
from flask import request, jsonify

from carrier import constant as cs
from carrier import db
from carrier.info import logger
from carrier.constant import ROLE_TYPE
import time
SESSION = db.session
# 邮件发送
def sm(receiver, password):
    msg = MIMEMultipart()
    msg['From'] = current_app.config['M_SENDER']
    msg['To'] = receiver
    msg['Subject'] = Header('Subject:来自员工管理系统的忘记密码', charset='UTF-8')  # 中文主题
    time = datetime.datetime.now()
    time = datetime.datetime.strftime(time, '%Y-%m-%d %H:%M:%S')
    txt = '亲爱的 用户：\n您好！您使用了忘记密码功能。\n您的密码是：\n' + password + '\n请妥善保管您的密码!\n'
    html = '<div style="font-family:microsoft yahei;font-size:14px;color:#41464e;line-height:32px;"><div style="font-size:18px;color:#41464e;font-weight:bold;">亲爱的用户：</div><div>您好！您使用了忘记密码功能。</div><div>您的密码是：<span style="font-size:20px;color:#de6434;">' + password + '</span></div> <div>请妥善保管您的密码!</div> <div style="font-size:12px;color:#717478;line-height:24px;margin:18px 0;border-bottom:1px solid #aaa;height:60px;"><div>如果您没有提出过忘记密码申请，请忽略此邮件。</div><div>' + time + '</div></div> <div style="align:center;font-size:12px;"><div>此邮件为系统自动发出的邮件，请勿直接回复</div></div> </div>'
    part1 = MIMEText(txt, 'plain', 'utf-8')
    part2 = MIMEText(html, 'html', 'utf-8')

    msg.attach(part1)
    msg.attach(part2)

    smtp = smtplib.SMTP()
    # smtp = smtplib.SMTP_SSL()
    smtp.connect(current_app.config['M_HOST'])
    smtp.login(current_app.config['M_SENDER'], current_app.config['M_PWD'])
    smtp.sendmail(current_app.config['M_SENDER'], receiver, msg.as_string())
    smtp.quit()
    print 'The mail to %s is sended successly.' % receiver

def request_data():
    if request.method in ('POST', 'PUT'):
        if hasattr(request, 'json') and request.json:
            return request.json
        else:
            return request.values
    else:
        return request.values

def resq_wrapper(code, rval=None):
    return jsonify({'code': code, 'errmsg': cs.ERR_MSG[code], 'data': rval})

# 记录日志
# 参数  remote_addr:请求IP地址，path:接口名字，method:请求方法，action:操作内容，result_code:操作结果编号，user_id:操作人用户id
def log_write(remote_addr, path, method, action, result_code, user_id):
    logger.info('client: %s, path: %s, method: %s, action:%s, result:%s, time:%s, user_id:%s' % (
                 remote_addr, path,    method,    action,  result_code,datetime.datetime.now(),user_id))

# 数据库提交
# 参数  lists:提交对象列表（list）
def db_commit_all(lists,logs):
    try:
        db.session.add_all(lists)
        db.session.commit()
        log_write(logs[0].remote_addr, logs[0].path,logs[0].method, logs[1],'1800',logs[2])
        return resq_wrapper(cs.OK)
    except Exception, e:
        logger.error(e)
        return resq_wrapper(cs.DB_COMMIT_ERR)
        # if json.loads(db_result.response[0])['code'] == 1828:
        #     return db_result

def db_flush(lists):
    db.session.add_all(lists)
    db.session.flush()

def return_role_list(*role):
    list=[]
    for item in role:
        list.append(ROLE_TYPE[item])
    return list

def str_to_list(str):
    return json.loads(str)

# 判断数据是否为空
def is_none(data):
    if data is None or data == 'null':
        return ''
    return data

# 获取用户信息
# 参数  user:用户对象
def get_user_message(user):
    return {'user_role': user.role, 'user_id': user.id}

# 获取随机密码
def gen_random_password(length=8, chars=string.ascii_letters + string.digits):
    return ''.join([choice(chars) for i in range(length)])

# two次md5加密
def gen_two_password(password):
    m2 = hashlib.md5()
    m2.update(password)
    m3 = m2.hexdigest()
    m4 = hashlib.md5()
    m4.update(m3)
    m5 = m4.hexdigest()
    return m5

# one次md5加密
def gen_one_password(password):
    m2 = hashlib.md5()
    m2.update(password)
    m3 = m2.hexdigest()
    return m3

def v_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in current_app.config['ALLOWED_EXTENSIONS']

# 判断用户传参问题
# 尽量所有参数全传,str类型非必传,int类型必传
def try_check_request_data(request_data, *lists):
    # 0 int; 1 str; 2 nothing;3 float
    # item[2] 0:非必传 1必传
    try:
        dic = dict()
        for item in lists:
            if item[2] == 1:
                if request_data.get(item[0]) == 'null' or request_data.get(item[0]) is None or request_data.get(
                        item[0]) == '':
                    return resq_wrapper(cs.REQUEST_VALUE_ERR, request_data + '缺少必传值！==^~~^==')
            value = request_data.get(item[0], '')
            key = item[0]
            type = item[1]
            if type == 0:
                if value == '':
                    dic.update({key: None})
                else:
                    dic.update({key: int(value)})
            elif type == 1:
                dic.update({key: str(value)})
            elif type == 2:
                dic.update({key: value})
            elif type == 3:
                if value == '':
                    dic.update({key: None})
                else:
                    dic.update({key: float(value)})
        return dic
    except TypeError, e:
        logger.error(e)
        return resq_wrapper(cs.REQUEST_TYPE_ERR, request_data)
    except ValueError, e:
        logger.error(e)
        return resq_wrapper(cs.REQUEST_VALUE_ERR, request_data)
    except Exception, e:
        logger.warning(e)
        return jsonify({'code': cs.EXCEPTION, 'errmsg': 'unexpected error : s%' % e, 'data': request_data})

def string_to_json(string_data):
    try:
        return json.loads(string_data)
    except:
        return None


def upload_file(file_upload, user_id, flag):
    if file_upload and v_file(file_upload.filename):
        timestamp = str(time.time()).replace(".", "")
        postfName = str(file_upload.filename.rsplit('.', 1)[1].lower())
        savename = user_id + '_' + flag + '_' + timestamp + '.' + postfName
        file_upload.save(os.path.join(current_app.config['UPLOAD_FOLDER'], savename))
        url = url_for('.index', _external=True) + current_app.config['UPLOAD_FOLDER'] + savename
        return url
    else:
        return None

#计算经纬度距离
def distance(long1, lat1, long2,lat2):
    R = 6378137; # 地球半径
    lat1 = lat1 * math.pi / 180.0;
    lat2 = lat2 * math.pi / 180.0;
    a = lat1 - lat2;
    b = (long1 - long2) * math.pi / 180.0;
    sa2 = math.sin(a / 2.0);
    sb2 = math.sin(b / 2.0);
    d = 2 * R * math.asin(math.sqrt(sa2 * sa2 + math.cos(lat1) * math.cos(lat2) * sb2 * sb2));
    return d;


def set_style(name, height, bold):
    # XFStyle用于设置字体样式，有描述字符串num_format_str，保护protection等属性。
    style = xlwt.XFStyle()
    # 字体font
    font = xlwt.Font()
    font.name = name
    font.bold = bold
    font.color_index = 2
    font.height = height  #
    style.font = font
    # 模式pattern
    pattern = xlwt.Pattern()
    pattern.pattern = xlwt.Pattern.SOLID_PATTERN  # 只有为True,背景色有效
    pattern.pattern_fore_colour = 1  # 单元格的背景色
    style.pattern = pattern

    # 设置边框样式
    borders = xlwt.Borders()
    borders.left = borders.THIN
    borders.right = borders.THIN
    borders.top = borders.THIN
    borders.bottom = borders.THIN
    style.borders = borders
    # 居中alignment
    alignment = xlwt.Alignment()
    alignment.horz = alignment.HORZ_CENTER
    style.alignment = alignment
    return style

#获取两个日期之间的日期
def get_date_list(begin_date, end_date):
    date_list = []
    begin_date = datetime.datetime.strptime(begin_date, "%Y-%m-%d")
    end_date = datetime.datetime.strptime(end_date, "%Y-%m-%d")
    while begin_date <= end_date:
        date_str = begin_date.strftime("%Y-%m-%d")
        date_list.append(date_str)
        begin_date += datetime.timedelta(days=1)
    return date_list

#获取今天日期
def get_today_date():
    return datetime.datetime.now().strftime("%Y-%m-%d")
    # return datetime.datetime.now().strftime("%Y年%m月%d日 %H:%M:%S")
#获取今天时间
def get_today_time():
    return datetime.datetime.now().strftime("%H:%M:%S")

#正则改变 邮箱字符串
def change_email_str(str):
    return re.sub(r'[\@\.]','_',str)

if __name__ == "__main__":
    print get_date_list('2017-01-27','2017-01-27')
    # print gen_one_password('teU3J1IL')
    print get_today_date()
