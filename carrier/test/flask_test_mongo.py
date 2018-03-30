#coding:utf8
from flask import Flask, jsonify
import time

from flask_sqlalchemy import SQLAlchemy, get_debug_queries

db = SQLAlchemy()
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:111111@127.0.0.1:3306/carrier_test?charset=utf8'
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN']=True
app.config['SECRET_KEY']='rgc is a good boy!hehe!'
# 启用缓慢查询记录功能
# app.config['SQLALCHEMY_RECORD_QUERIES']=True
app.config['FLASKY_DB_QUERY_TIMEOUT']=0.00000000001
db.init_app(app)

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column('id', db.Integer, primary_key=True, autoincrement=True)
    email = db.Column('email', db.String(64), unique=True)  # 邮箱

    def __init__(self, email):
        self.email = email

    def to_dict(self):
        output_dict = {}
        output_dict.update(self.__dict__)
        if "_sa_instance_state" in output_dict:
            del output_dict['_sa_instance_state']
        return output_dict

@app.teardown_request
def handle_teardown_request(ex):
    db.session.remove()

@app.after_request
def after_request(response):
    #录影响性能的缓慢数据库查询
    for query in get_debug_queries():
        if query.duration >= app.config['FLASKY_DB_QUERY_TIMEOUT']:
            print '#####Slow query:%s \nParameters:%s \nDuration:%fs\nContext:%s\n #####'% \
            (query.statement, query.parameters, query.duration,query.context)
    return response

@app.route('/users/<email>')
def line_test(email):
    result_id=db.session.query(User.id).filter_by(email=email).first()
    return jsonify({'code':200,'email':email,'id':result_id[0]})

if __name__=='__main__':
    app.run(debug=True)