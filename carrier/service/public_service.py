# -*- coding: utf-8 -*-
import cgi
import datetime
import hashlib
import json
import math
import re
import smtplib
import string
from email.header import Header
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from random import choice

import xlwt
from flask import current_app
from flask import request, jsonify

from carrier import constant as cs
from carrier import db
from carrier.constant import ROLE_TYPE
from carrier.info import logger

SESSION = db.session

def sm(receiver, password):
    """
    邮件发送
    :param receiver:邮件接收方帐号
    :param password:用户新密码
    """

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
    """
    获取请求数据
    """
    if request.method in ('POST', 'PUT'):
        if hasattr(request, 'json') and request.json:
            return request.json
        else:
            return request.values
    else:
        return request.values

def resq_wrapper(code, rval=None):
    """
    api接口返回格式
    :param code:状态码
    :param rval:返回的数据
    """
    return jsonify({'code': code, 'errmsg': cs.ERR_MSG[code], 'data': rval})

def log_write(remote_addr, path, method, action, result_code, user_id):
    """
    记录日志
    :param remote_addr:请求IP地址
    :param path:接口名字
    :param method:请求方法
    :param action:操作内容
    :param result_code:操作结果编号
    :param user_id:操作人用户id
    """

    logger.info('client: %s, path: %s, method: %s, action:%s, result:%s, time:%s, user_id:%s' % (
                 remote_addr, path,    method,    action,  result_code,datetime.datetime.now(),user_id))


def db_commit_all(lists,logs):
    """
    数据库提交
    :param lists:提交对象列表
    :param logs:日志列表
    """

    try:
        SESSION.add_all(lists)
        SESSION.commit()
        log_write(logs[0].remote_addr, logs[0].path,logs[0].method, logs[1],'1800',logs[2])
        return resq_wrapper(cs.OK)
    except Exception, e:
        SESSION.rollback()
        logger.error(e)
        return resq_wrapper(cs.DB_COMMIT_ERR)

def db_flush(lists):
    """
    更改内存中数据库数据
    :param lists: 提交对象列表
    """

    SESSION.add_all(lists)
    SESSION.flush()


def return_role_list(*role):
    """
    返回权限列表
    :param role: 权限列表
    """

    list=[]
    for item in role:
        list.append(ROLE_TYPE[item])
    return list


def is_none(data):
    """
        判断数据是否为空
        :param data: 数据
        """
    if data is None or data == 'null':
        return ''
    return data


def gen_random_password(length=8, chars=string.ascii_letters + string.digits):
    """
    获取随机密码
    :param length:密码长度
    :param chars:字符
    :return:随机密码字符串
    """
    return ''.join([choice(chars) for i in range(length)])

def gen_two_password(password):
    """
    两次md5加密
    :param password: 原始密码
    :return: 两次md5加密的密码
    """
    m2 = hashlib.md5()
    m2.update(password)
    m3 = m2.hexdigest()
    m4 = hashlib.md5()
    m4.update(m3)
    m5 = m4.hexdigest()
    return m5

def gen_one_password(password):
    """
    一次md5加密
    :param password:原始密码
    :return:一次md5加密的密码
    """
    m2 = hashlib.md5()
    m2.update(password)
    m3 = m2.hexdigest()
    return m3

def v_file(filename):
    """
    判断文件类型
    :param filename:文件名称
    :return:true or false
    """

    return '.' in filename and filename.rsplit('.', 1)[1].lower() in current_app.config['ALLOWED_EXTENSIONS']

def try_check_request_data(request_data, *lists):
    """
    判断用户传参问题
    :param request_data: 请求的数据
    :param lists: 多个列表
                item[0] 请求的参数
                item[1] 0 int; 1 str; 2 nothing;3 float
                item[2] 0:非必传; 1必传
    """

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
                # 不信任用户输入，转义html标签
                dic.update({key:cgi.escape(str(value))})
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
    """
    json或list字符串转换为对应数据
    :param string_data: json或list字符串
    :return: list or json
    """
    try:
        return json.loads(string_data)
    except:
        return None


def distance(long1, lat1, long2,lat2):
    #计算经纬度坐标间距离
    """

    :param long1:经度1
    :param lat1:纬度1
    :param long2:经度2
    :param lat2:纬度2
    :return:坐标间距离
    """
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
    """
    设置excel表格样式
    :param name: 字体名字
    :param height:字体高度
    :param bold:字体粗体字
    :return:表格样式
    """

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


def get_date_list(begin_date, end_date):
    """
    获取两个日期之间的日期
    :param begin_date: 开始日期
    :param end_date:结束日期
    :return:日期列表
    """
    date_list = []
    begin_date = datetime.datetime.strptime(begin_date, "%Y-%m-%d")
    end_date = datetime.datetime.strptime(end_date, "%Y-%m-%d")
    while begin_date <= end_date:
        date_str = begin_date.strftime("%Y-%m-%d")
        date_list.append(date_str)
        begin_date += datetime.timedelta(days=1)
    return date_list


def get_today_date():
    """
    获取今天日期
    :return:今天日期
    """
    return datetime.datetime.now().strftime("%Y-%m-%d")
    # return datetime.datetime.now().strftime("%Y年%m月%d日 %H:%M:%S")

def get_today_time():
    """
    获取今天时间
    :return: 今天时间
    """
    return datetime.datetime.now().strftime("%H:%M:%S")


def change_email_str(str):
    """
    正则改变 邮箱字符串
    for example: 123@qq.com  ==>  123_qq_com
    :param str:邮箱字符串 '123@qq.com '
    :return: '123_qq_com'
    """
    return re.sub(r'[\@\.]','_',str)



if __name__ == "__main__":
    print get_date_list('2017-01-27','2017-01-27')
    # print gen_one_password('teU3J1IL')
    print get_today_date()