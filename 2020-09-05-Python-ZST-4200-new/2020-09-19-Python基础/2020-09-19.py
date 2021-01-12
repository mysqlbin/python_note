
"""
    *args：
        用来将参数打包成 tuple(元组) 给函数体调用
        表示任何多个无名参数，它本质是一个tuple；
        
    **kwargs：
        用来将参数打包成 dict(词典)) 给函数体调用
        表示关键字参数，它本质上是一个dict；
"""
def weather(name, time, *args, **kwargs):
    print(name)
    print(time)
    print(args)
    print(type(args))
    print(kwargs)
    print(type(kwargs))

def week(*args, **kwargs):
    print(args)
    print(kwargs)

# 在函数内部修改函数外部的变量
a = 'a'

def f():
    global a
    a = 'b'
    print(a)


if __name__ == '__main__':

    # weather('zst', '20200919')
    # weather(name='zst', time='20200919')
    # weather("1", "2")
    # weather('zst', '20200919', "a", "b", "cde")
    weather('zst', '20200919', "a", "b", "cde", k=1, v=3)

    print(".....................")

    # week('zst', '20200919', "a", "b", "cde", k=1, v=3)

    print(".....................")

    # print(a)
    # f()
    # print(a)

    print(".....................")

    # 可变数据类型-列表的修改(原地修改)
    # l_a = [1, 2]
    # print("id(id)", id(l_a))
    # l_a.append(3)
    # print("id(la)", id(l_a))
    # print("l_a value", l_a)

    """
        id(id) 2557599872264
        id(la) 2557599872264
        l_a value [1, 2, 3]
    """
    print(".....................")

    # 列表的扩容
    # l_a = [1, 2]
    # print("l_a before change", l_a, id(l_a))
    # l_a.append(3)
    # print("l_a after change", l_a, id(l_a))
    # for i in range(10000000):
    #     l_a.append(i)
    # print("l_a after many changes", len(l_a), id(l_a))

    """
        l_a before change [1, 2] 40246280
        l_a after change [1, 2, 3] 40246280
        l_a after many changes 10000003 40246280
        
        扩容后(拆迁后)的内存地址没有变化
    """

    # 列表的引用，相当于是别名(对象的引用)
    # l_a = [1, 2]
    # l_b = l_a
    # """
    #     区别：
    #       l_a = [1, 2]
    #       l_b = [1, 2]
    # """
    # print("l_a", id(l_a))
    # print("l_b", id(l_b))
    # print("l_a length before l_b append", l_a, len(l_a))
    # l_b.append(1)
    # print("l_b length after l_b append", l_b, len(l_b))
    # print("l_a length after l_b append", l_a, len(l_a))

    """
        l_a 2404859442504
        l_b 2404859442504
        l_a length before l_b append [1, 2] 2
        l_b length after l_b append [1, 2, 1] 3
        l_a length after l_b append [1, 2, 1] 3
    """

    print(".....................")

    # 不可变类型-字符串string
    # a_str = "zst"
    # print("a_str before change", a_str, id(a_str))
    #
    # a_str = "python"
    # print("a_str after change", a_str, id(a_str))

    """
        a_str before change zst 2095443116808
        a_str after change python 2095443255344
    """


    print(".....................")

    # 可变类型： 在函数内部修改传参的列表，函数外的列表也会发生改变。
    # 传值
    # def lfunc(l):
    #     print("in func", l, id(l))
    #     l.append(1)
    #     print("in func append after", l, id(l))
    # l = []
    # print("out of func", l, id(l))
    # lfunc(l)
    # print("out of func", l, id(l))

    """
        out of func [] 1535551993992
        in func [] 1535551993992
        in func append after [1] 1535551993992
        out of func [1] 1535551993992
        这里理解了，可以参考老师画的图来理解。
    """
    print(".....................")


    # 不可变类型：在函数内部修改传参的变量，函数外的变量不会发生改变。
    # 不可变类型在函数中传递的变化
    # b = 1
    # def func(a):
    #     print("a id", a,  id(a))
    #     a += 1
    #     # 数值型是不可变的数据类型，所以 a += 1 实际了开辟了新的一块内存地址。
    #     print("a after add", a, id(a))
    # print("before func", b, id(b))
    # func(b)
    # print("after func", b, id(b))

    """
        before func 1 500591360
        a id 1 500591360
        a after add 2 500591392
        after func 1 5005913606
        这里理解了，可以参考老师画的图来理解。
    """

    # a = 1
    # def funct(a):
    #     print(a)
    #
    # funct(a)

    # 明白 str 跟 bytes 的互相转换
    # a_str = "中国"
    # str 转换为  bytes
    # print(a_str.encode('utf-8'))
    #    bytes 转换为 str
    # print(a_str.encode('utf-8').decode('utf-8'))
    # bytes的表达方式
    # a_bytes = b'abcdf'
    # print(a_bytes)

    print(".....................")

    # def use_type(name):
    #     # 希望name是一个字符串
    #     if type(name) != str:
    #         raise Exception("name must be string")
    #     pass
    #
    # use_type(1)
    # Exception: name must be string


    # def use_isinstance(name):
    #     # 希望name是一个字符串
    #     if not isinstance(name, str):
    #         raise Exception("name must be string")
    #     pass
    # use_isinstance(1)

    # Exception: name must be string

    # 单个参数的：
    # g = lambda x: x ** 2
    # print(type(g))
    # print(g(2))
    # # 多个参数的：
    # g = lambda x, y, z: (x + y) ** z
    # print(g(1, 2, 3))
    """
    <class 'function'>
    4
    27
    """

    # 字符串的intern机制
    # a_str = "abc"
    # b_str = "abc"
    # """
    #     等价于 b_str = a_str
    # """
    # print('a_str', id(a_str))
    # print('b_str', id(b_str))
    # # == 是查看内容是否一样， is 表示内存地址是否一样 id(xx) == id(xx)
    # #
    # if a_str is b_str:
    #     print("true")
    # else:
    #     print("false")
    # # true
    #
    a_list = ['a', 'b', 'c']
    b_list = ['a', 'b', 'c']
    print("a_list", id(a_list))
    print("b_list", id(b_list))
    """
        a_list 40085640
        b_list 40115144
        a_list 和 b_list 是两个不同的列表对象，所以它们的内存地址是不一样的。
    """
    # if a_list is b_list:
    #     print("true")
    # else:
    #     print("false")
    # false

    # l_a = [1, 2]
    # l_b = l_a
    # print("l_a", id(l_a))
    # print("l_b", id(l_b))

    """
        l_a 37791752
        l_b 37791752
        
    """

    # Python运算符优先级和结合性
    """
    >>> print(True or True and False)
    True
    >>> print(1 or 5 and 4)
    1
    >>> print((1 or 5) and 4)
    4
    >>> print(1 and 4)
    4
    >>> print(1 or 5)
    1
    
    >>> print(True and False)
    False
    
    >>> print(False and True)
    False
    
    >>> print(True or False)
    True
    
    >>> print(False or True)
    True
    
    # or：只要有一个为真就为真
    # and: 只要有一个为假就为假

    >>> print(4+1|2)
    7
    # 4+1+2
    
    """

    # 迭代器
    # it = iter([1, 2, 3, 4, 5])
    # while True:
    #     try:
    #         x = next(it)
    #         print(x)
    #     except StopIteration:
    #         break
    """
    1
    2
    3
    4
    5
    """

    # import re
    # str = 'abc ABCD AbC'
    # pattern = re.compile(r'abc', re.I)
    # m = pattern.finditer(str)
    # if m:
    #     while True:
    #         try:
    #             x = next(m)
    #             print(x)
    #             print(x.group())
    #         except StopIteration:
    #             break
    # else:
    #     print("not find")

    """
    <_sre.SRE_Match object; span=(0, 3), match='abc'>
    abc
    <_sre.SRE_Match object; span=(4, 7), match='ABC'>
    ABC
    <_sre.SRE_Match object; span=(9, 12), match='AbC'>
    AbC
    """
    # for x, y in zip(range(2), range(4)):
    #     print(x, y)
    """
    0 0
    1 1
    """

    # for x, y in zip(range(4), range(2)):
    #     print(x, y)
    """
    0 0
    1 1
    """

    # from itertools import zip_longest
    # for x, y in zip_longest(range(4), range(2)):
    #     print(x, y)
    """
    0 0
    1 1
    2 None
    3 None
    """

    # from itertools import zip_longest
    # for x, y in zip_longest(range(2), range(4)):
    #     print(x, y)
    """
    0 0
    1 1
    None 2
    None 3
    """

    # yield 关键字
    # 定义一个生成器的函数
    def generator_function(n):
        for i in range(n):
            yield i
            # 相当于是 return

    for item in generator_function(5):
        print(item)

    for item in range(5):
        print(item)
