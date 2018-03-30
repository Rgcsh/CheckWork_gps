#coding:utf8
from flask import Flask, url_for, redirect, request
from celery import Celery
from celery import platforms
from celery import task

app = Flask(__name__)
app.debug=True
app.config['SERVER_NAME']='127.0.0.1:3200'

def make_celery(app):
    #broker是一个消息传输的中间件
    # backend用于存储这些消息以及celery执行的一些消息和结果
    celery=Celery('flask_test',
           broker=app.config['CELERY_BROKER_URL'],
           backend=app.config['CELERY_RESULT_BACKEND'])
    return celery

app.config['CELERY_BROKER_URL']='redis://localhost:6379/0'
app.config['CELERY_RESULT_BACKEND']='redis://localhost:6379/1'
celery=make_celery(app)

@task
def celery_func(a):
    return a

@app.route('/celery_test')
def celery_test():
    print 'route celery_test haven started!'
    for i in range(10):
        celery_func.delay(11121)
    return 'celery_func have given to celery!'

if __name__ == '__main__':
    app.run(debug=True)

    # http://python.jobbole.com/84041/
    # https://blog.csdn.net/liuxiaochen123/article/details/47981111
    # https://zhuanlan.zhihu.com/p/22304455
    #first:start celery service:   celery -A flask_test.celery worker --loglevel=info
    #than:run app