# -*- coding:utf-8 -*-

OK = 1800
SERVER_ERR = 1801
LOGIN_FAIL = 1802
NOT_ALLOW = 1803
COMMITED = 1804
REGISTERED = 1805
NO_USER = 1806
METHOD_ERR = 1807
NO_DATA = 1808
TEMP_TOKEN = 1809
DB_ERROR = 1810
NO_TOKEN = 1811
PASSWD_ERR = 1812
TOKEN_EXPIRE = 1813
PARAMS_ERR = 1814
#非打回管理员,无法审核
REQUEST_TYPE_ERR=1815
REQUEST_VALUE_ERR=1816
EXCEPTION=1817
DB_COMMIT_ERR=1818
STR_TO_DICT_LIST_ERR=1819
BD_ADD_ENTITY_ERROR=1820
BD_ADD_FENCE_ERROR=1821
BD_DELETE_FENCE_ERROR=1822
BD_UPDATE_FENCE_ERROR=1823
BD_QUERY_FENCE_ERROR=1824
OUT_FENCE=1825
IN_FENCE=1826
HAVEN_COLOCK=1827
PASTED_MORNNING_COLOCK=1828
EMPTY_FENCE=1829
TRANS_POINT_FAIL=1830
REQUEST_GET_VAL_fAIL=1831
BD_GETLAST_POINT_FAIL=1832
CAN_NOT_CLOCK=1833

ERR_MSG = {
    1800: 'success',
    1801: 'server err!',
    1802: 'login fail!',
    1803: 'not allow!',
    1804: 'commited',
    1805: 'registered',
    1806: 'no user',
    1807: 'method err!',
    1808: 'no data',
    1809: 'tmp token',
    1810: 'db err',
    1811: 'NO TOKEN',
    1812: 'passwd error!',
    1813: 'token expire!',
    1814: 'params_err!',
    1815: 'request type error!',
    1816: 'request value error!',
    1817: 'unexpected error!',
    1818: 'db commit transaction error!',
    1819: '字符串转换为list或dict失败!',
    1820: 'entity创建失败!',
    1821: 'add围栏失败!',
    1822: 'delete围栏失败!',
    1823: 'update围栏失败!',
    1824: 'query围栏失败!',
    1825: 'out fence!',
    1826: 'IN fence!',
    1827: '已打卡!!!',
    1828: '已过早班时间，无法打上班卡!',
    1829: 'NO FENCE',
    1830: '坐标转换失败!',
    1831: '数据类型取值失败!',
    1832: '查询最后的上传坐标失败!',
    1833: '无法打卡',
}


ROLE_TYPE = {
    "manager": 1, #manager
    "user": 2, #normal user
}

