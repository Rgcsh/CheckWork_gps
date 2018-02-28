from flask import Flask, url_for, redirect, request
from celery import Celery
from celery import platforms
from celery import task

app = Flask(__name__)
app.debug=True
app.config['SERVER_NAME']='127.0.0.1:3200'
def te():
    return 'te'

app.add_url_rule('/te',view_func=te)

platforms.C_FORCE_ROOT=True

def make_celery(app):
    celery=Celery(app.name,
           broker=app.config['CELERY_BROKER_URL'],
           backend=app.config['CELERY_RESULT_BACKEND'])
    return celery

app.config['CELERY_BROKER_URL']='redis://localhost:6379/0'
app.config['CELERY_RESULT_BACKEND']='redis://localhost:6379/1'
celery=make_celery(app)


@app.route('/t')
def hello_world():
    return 'Hello World!!'

@app.route('/rgc1')
def rgc():
    print request.values.get('name')
    return 'Hello rgc! %s' % (request.values.get('name'))

@app.route('/test/<name>')
def test(name):
    print name
    print request.values
    if name=='rgc':
        return redirect(url_for('rgc',name=request.values.get('name')))
    elif name=='t':
        return redirect(url_for('hello_world'))
    else:
        return name


@task
def celery_func(a):
    return a

@app.route('/celery_test')
def celery_test():
    print 'route celery_test haven started!'
    for i in range(10):
        celery_func.delay(11121)
    return 'celery_func have given to celery!'

# 0.0.0.0:5000/test/rgc?name=12&key=122
if __name__ == '__main__':
    app.run()
