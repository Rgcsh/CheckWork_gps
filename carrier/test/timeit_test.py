#coding:utf8
from timeit import repeat

def func():
    s = 0
    for i in range(1000):
        s += i

#repeat和timeit用法相似，多了一个repeat参数，表示重复测试的次数(可以不写，默认值为3.)，返回值为一个时间的列表。
t = repeat('func()', 'from __main__ import func', number=100, repeat=5)
print(t) 
print(min(t))