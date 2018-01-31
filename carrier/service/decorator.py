# -*- coding:utf-8 -*-

from functools import partial
from functools import wraps
from time import time

from flask import g
from flask import request

from carrier import constant as cs
from carrier import redis_store
from carrier.info import logger
from carrier.service.public_service import return_role_list
from public_service import request_data, resq_wrapper as rw


# 请求参数
def request_info(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        request_infos = ' '.join(
            [request.method, request.path, str(request_data())])
        logger.info('Request: %s', request_infos)
        func_return = f(*args, **kwargs)
        response_info = str(func_return.response)
        if request.method == 'POST':
            logger.info('Response:%s', response_info)
        else:
            logger.info('Response:%s', response_info)
        func_return.headers.__dict__.get('_list').append(("Access-Control-Allow-Origin", "*"))
        return func_return

    return decorator


# 判断能否登录
def v_login(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        token = request_data().get('token')
        if not token:
            return rw(cs.NO_TOKEN)
        email = redis_store.hmget('token:%s' % token, 'email')
        if not email:
            return rw(cs.TOKEN_EXPIRE)
        return f(*args, **kwargs)

    return decorator


# 只是normal user权限
def v_normal_role(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        user = g.user
        role = user.role_type
        logger.info('client: %s, path: %s, method: %s' % (request.remote_addr, request.path, request.method))
        if role not in return_role_list('user'):
            return rw(cs.NOT_ALLOW)
        return f(*args, **kwargs)

    return decorator


# manager权限
def v_manager_role(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        user = g.user
        role = user.role_type
        logger.info('client: %s, path: %s, method: %s' % (request.remote_addr, request.path, request.method))
        if role not in return_role_list('manager'):
            return rw(cs.NOT_ALLOW)
        return f(*args, **kwargs)

    return decorator


# 检查重复提交
def check_resubmit(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        email = g.user.email
        socket_name = f.__name__
        result = redis_store.get('%s_%s' % (email, socket_name))
        if result:
            return rw(cs.RESUBMIT)
        else:
            redis_store.setex('%s_%s' % (email, socket_name), 2, 'Y')
        return f(*args, **kwargs)

    return decorator


# 计算接口所花费时间
def timing(func=None):
    if func is None:
        return partial(timing)

    @wraps(func)
    def _wrapper(*args, **kwargs):
        start_time = time()
        result = func(*args, **kwargs)
        end_time = time()
        print(u'运行花费时间：{:.6f}s。'.format(end_time - start_time))
        return result

    return _wrapper
