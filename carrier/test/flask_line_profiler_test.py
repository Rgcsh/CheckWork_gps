#coding:utf8
from flask import Flask, jsonify
import time
from functools import wraps
from line_profiler import LineProfiler

#查询接口中每行代码执行的时间
def func_line_time(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        func_return = f(*args, **kwargs)
        lp = LineProfiler()
        lp_wrap = lp(f)
        lp_wrap()
        lp.print_stats()
        return func_return
    return decorator

app = Flask(__name__)

@app.route('/line_test')
@func_line_time
def line_test():
    for item in range(5):
        time.sleep(1)
    for item in xrange(5):
        time.sleep(0.5)
    return jsonify({'code':200})

if __name__=='__main__':
    app.run(host='127.0.0.1',port=4000,debug=True)

