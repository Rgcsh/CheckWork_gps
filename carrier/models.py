# -*- coding:utf-8 -*-

__version__ = '0.1'
__author__ = 'RGC'
__date__ = '2017-11-07'

import datetime

from . import db


#用户表
class User(db.Model):
    __tablename__ = 'user'
    id = db.Column('id',db.Integer,primary_key=True,autoincrement=True)
    password = db.Column('password',db.String(256),nullable=False)  #密码
    email = db.Column('email',db.String(64),unique=True)  #邮箱
    role_type = db.Column('role_type',db.Integer,nullable=False) #1:manager 2:normal user
    username = db.Column('username',db.String(32),index=True) #用户名

    user_no = db.Column('user_no',db.String(32),index=True,unique=True) # 用户工号
    user_department = db.Column('user_department',db.String(32)) # 部门
    photo_url = db.Column('photo_url',db.TEXT) #头像地址
    create_time = db.Column('create_time',db.TIMESTAMP,default=datetime.datetime.now()) #创建时间
    update_time = db.Column('update_time',db.TIMESTAMP) #更新时间

    def __init__(self,username,password,email,role_type):
        self.username = username
        self.password = password
        self.email = email
        self.role_type = role_type

    def to_dict(self):
        dict = {}
        dict.update(self.__dict__)
        if "_sa_instance_state" in dict:
            del dict['_sa_instance_state']
        return dict

class Check_work(db.Model):
    __tablename__ = 'check_work'
    id = db.Column('id',db.Integer,primary_key=True,autoincrement=True)
    user_id=db.Column('user_id',db.Integer, db.ForeignKey(User.id), nullable=False) # user.id
    date=db.Column('date',db.String(12),index=True) # 日期
    start_time=db.Column('start_time',db.String(10)) # start时间
    end_time=db.Column('end_time',db.String(10)) # end时间

    def __init__(self,date,user_id):
        self.date = date
        self.user_id = user_id

    def to_dict(self):
        dict = {}
        dict.update(self.__dict__)
        if "_sa_instance_state" in dict:
            del dict['_sa_instance_state']
        return dict