#coding:utf8
import cgi
import time
from line_profiler import LineProfiler
from memory_profiler import profile

def test2():
    print 'hello!test2()'

@profile(precision=4,stream=open('memory_profiler.log','w+'))
def test1():
    html='''<script>alert("you are a good boy!&I like you")</scrpit>'''
    test2()
    escape_html=cgi.escape(html)
    c=0
    for item in xrange(100000):
        c+=1
    print c
    print escape_html

test1()
# if __name__=='__main__':
    # lp=LineProfiler()
    # #同时显示函数每行所用时间和调用函数每行所用时间，加入add_function()
    # lp.add_function(test2)
    # lp_wrap=lp(test1)
    # lp_wrap()
    # lp.print_stats()