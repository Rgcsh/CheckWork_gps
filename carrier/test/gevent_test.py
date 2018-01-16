#! /usr/bin/env python
# -*- coding:utf-8 -*-

from greenlet import greenlet
# greenlet 其实就是手动切换；gevent是对greenlet的封装，可以实现自动切换

def test1():
    print("123")
    gr2.switch()   # 切换去执行test2
    print("456")
    gr2.switch()   # 切换回test2之前执行到的位置，接着执行

def test2():    
    print("789")
    gr1.switch()   # 切换回test1之前执行到的位置，接着执行
    print("666")


gr1 = greenlet(test1)   # 启动一个协程 注意test1不要加()
gr2 = greenlet(test2)   #
gr1.switch()