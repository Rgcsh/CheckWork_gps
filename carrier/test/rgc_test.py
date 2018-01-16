# -*- encoding:utf-8 -*-
import json
import requests

import time
from datetime import datetime


HEADES = {'Content-type': 'application/json'}

# URL='http://192.168.1.133:5000'
# URL='http://127.0.0.1:5000'
URL='http://120.27.110.143:3000'

def fence_list():
    search_info = {'fence_ids':1}
    r = requests.get(URL + '/fence/list',params=search_info)
    print r.text

def fence_historyalarm():
    search_info = {'fence_ids':1,'monitored_person':'rgc'}
    r = requests.get(URL + '/fence/historyalarm',params=search_info)
    print r.text

def fence_querystatus():
    search_info = {'token':Token,'onwork':2}
    r = requests.get(URL + '/fence/querystatus',params=search_info)
    print r.text

def carrier_up_map():
    search_info = {'token':Token,'lat':31.220162 ,'lon':121.260659}
    r = requests.post(URL+'/carrier/up_map', data=search_info)
    print r.text

def updatecirclefence():
    search_info = {'fence_id':1 ,
                   'fence_name':'first_fence',
                   'longitude':121.260659,
                   'latitude':31.220162,
                   'radius':1000,
                   'denoise':0}
    r = requests.post(URL+'/fence/updatecirclefence', data=search_info)
    print r.text
# TOKEN = 'df'
# TOKEN = login()
# print TOKEN

def login():
    search_info = {'password': '68cf63c62bc68d71fc41c028375e2f6e', 'email': '202095657@qq.com'}
    # search_info = {'password':'68cf63c62bc68d71fc41c028375e2f6e' ,'email':'2020956572@qq.com'}
    # search_info = {'password': '68cf63c62bc68d71fc41c028375e2f6e', 'email': 'rgc@qq.com'}
    # search_info = {'password': '68cf63c62bc68d71fc41c028375e2f6e', 'email': 'rgc1@qq.com'}
    r = requests.post(URL + '/carrier/login', data=search_info)
    print r.text
    return json.loads(r.text)['data']['token']

def carrier_logout():
    search_info = {'token':login()}
    r = requests.get(URL + '/carrier/logout',params=search_info)
    print r.text

def reset_password():
    search_info = {'token':login(),'new_password':'68cf63c62bc68d71fc41c028375e2f6e' ,'old_password':'c488e7d554ce63b9cdd5d52863177cc2'}
    # search_info = {'password': '68cf63c62bc68d71fc41c028375e2f6e', 'email': '2020956572@qq.com'}
    r = requests.put(URL + '/carrier/passwd', data=search_info)
    print r.text

def forget_password():
    search_info = {'email':'2020956572@qq.com'}
    # search_info = {'password': '68cf63c62bc68d71fc41c028375e2f6e', 'email': '2020956572@qq.com'}
    r = requests.put(URL + '/carrier/password', data=search_info)
    print r.text

def export():
    search_info = {'token':Token,'user_list':'[4,5,7,8]' ,'start_date':'2017-11-23','end_date':'2017-11-23'}
    r = requests.post(URL+'/carrier/export', data=search_info)
    print r.text


# Token=login()
Token='df'

def delete_fence():
    r = requests.post(URL+'/fence/delete',data={'fence_ids':3})
    print r.text

def register():
    # search_info = {'password':'68cf63c62bc68d71fc41c028375e2f6e' ,'email':'2020956572@qq.com','role_type':2,'username':'rgc'}
    search_info = {'password':'68cf63c62bc68d71fc41c028375e2f6e' ,'email':'rgc1@qq.com','role_type':2,'username':'rgc1'}
    r = requests.post(URL+'/carrier/users', data=search_info)
    print r.text

def register_all(email,username):
    # search_info = {'password':'68cf63c62bc68d71fc41c028375e2f6e' ,'email':'2020956572@qq.com','role_type':2,'username':'rgc'}
    search_info = {'password':'68cf63c62bc68d71fc41c028375e2f6e' ,'email':email,'role_type':2,'username':username}
    r = requests.post(URL+'/carrier/users', data=search_info)
    return r.text

if __name__ == '__main__':
    for item in range(9,120):
        result_regi=register_all(str(item)+'@qq.com',item)
        print json.loads(result_regi)['code'],item


    # delete_fence()
    # register()
    # carrier_logout()
    # reset_password()
    # forget_password()


    # carrier_up_map()
    # time.sleep(1)
    # fence_querystatus()
    # export()

    # updatecirclefence()
    # fence_list()
    # r = requests.get('127.0.0.1:3000/carrier/logout')
    # print r.text
    # fence_historyalarm()