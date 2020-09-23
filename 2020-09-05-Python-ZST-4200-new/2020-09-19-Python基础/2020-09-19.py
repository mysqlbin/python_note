
"""
    *args 用来将参数打包成 tuple(元组) 给函数体调用
    **kwargs 用来将参数打包成 dict(词典)) 给函数体调用
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
    # weather('zst', '20200919', "a", "b", "cde", k=1, v=3)

    print(".....................")

    week('zst', '20200919', "a", "b", "cde", k=1, v=3)

    print(".....................")

    # print(a)
    # f()
    # print(a)

    print(".....................")

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
    """

    # 相当于是别名
    # l_b = l_a
    # print("l_b", id(l_b))
    # print("l_a length before l_b append", l_a, len(l_a))
    # l_b.append(1)
    # print("l_b length after l_b append", l_a, len(l_b))
    # print("l_a length after l_b append", l_a, len(l_a))


    print(".....................")

    # a_str = "zst"
    # print("a_str before change", a_str, id(a_str))
    #
    # a_str = "python"
    # print("a_str after change", a_str, id(a_str))

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

    # a_str = "abc"
    # b_str = "abc"
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
    # a_list = ['a', 'b', 'c']
    # b_list = ['a', 'b', 'c']
    # print("a_list", id(a_list))
    # print("b_list", id(b_list))
    # if a_list is b_list:
    #     print("true")
    # else:
    #     print("false")
    # false


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

    # 字典对象的浅拷贝
    # a = {
    #     'l': [1, 2, 3]
    # }
    # b = a.copy()
    # print("a", id(a))
    # print("b", id(b))
    # print("a.l", id(a["l"]))
    # print("b.l", id(b["l"]))
    #
    # a["l"].append(4)
    #
    # print(a["l"], id(a["l"]))
    # print(b["l"], id(b["l"]))

    """
        a 35150440
        b 35150872
        a.l 37559304
        b.l 37559304
        [1, 2, 3, 4] 37559304
        [1, 2, 3, 4] 37559304

        变量a的数据字典 {'l': [1, 2, 3]} 是一个父对象
        [1, 2, 3] 是变量a的子对象
        b = a.copy(): 
            发生了一次浅拷贝，变量b开辟了一块新的内存地址 2793259092512，变量b的子对象 [1, 2, 3, 4] 还是指向已有的内存地址 2793260805768
            所以当变量a的列表子对象发生改变，变量b的列表子对象也会发生改变。
        
    """

    # 字典对象的深拷贝与修改
    # import copy
    # a = {
    #     'l': [1, 2, 3]
    # }
    # b = copy.deepcopy(a)
    # print("a", id(a))
    # print("b", id(b))
    # print("a.l", id(a["l"]))
    # print("b.l", id(b["l"]))
    #
    # a["l"].append(4)
    # print(a["l"], id(a["l"]))
    # print(b["l"], id(b["l"]))

    """
        a 36854376
        b 37317440
        a.l 40146696
        b.l 40146760
        [1, 2, 3, 4] 40146696
        [1, 2, 3] 40146760
         
        变量a的数据字典 {'l': [1, 2, 3]} 是一个父对象
        [1, 2, 3] 是变量a的子对象
        
        b = copy.deepcopy(a)：
            发生了一次深拷贝，变量b开辟了一块新的内存地址 1827203735488，变量b的子对象 [1, 2, 3] 还是指新的内存地址 1827203643272
            所以当变量a的列表子对象发生改变，变量b的列表子对象不会发生改变。
            因为深拷贝完全拷贝了一份数据，所以数据的修改不会互相影响。
    """

    # 单层的list列表对象使用 copy()方法

    a = [1, 2, 3]
    b = a.copy()
    print("a", id(a))
    print("b", id(b))
    print("a id(a[0])", id(a[0]))
    print("b id(b[0])", id(b[0]))
    a.append(4)
    print("a after a.append()", a)
    print("b after a.append()", b)
    print("a after a.append()", id(a))
    print("b after a.append()", id(b))
    print("a after a.append() id(a[0])", id(a[0]))
    print("b after a.append() id(b[0])", id(b[0]))

    """
        a 36716936
        b 36716872
        a id(a[0]) 493185792
        b id(b[0]) 493185792
        a after a.append() [1, 2, 3, 4]
        b after a.append() [1, 2, 3]
        a after a.append() 36716936
        b after a.append() 36716872
        a after a.append() id(a[0]) 493185792
        b after a.append() id(b[0]) 493185792
    
        对于单层的list来说，使用浅拷贝，实际上用的是深拷贝
        最外层的内存地址不一样
        子对象的内存一样，但是 列表a发生修改后，列表b并没有发生改变。
        
        
        
        
        
    """

    # 嵌套的list列表对象使用 copy()方法
    # a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    # b = a.copy()
    # print("a", id(a))
    # print("b", id(b))
    # print("a id(a[0]", id(a[0]))
    # print("b id(b[0]", id(b[0]))
    # a[0].append(4)
    # print("b after a.append()", b)
    # print("b after a.append()", id(b))
    #
    # print("a after a.append()", id(a[0]))
    # print("b after a.append()", id(b[0]))

    """
        a 40846600
        b 40959432
        a id(a[0] 40845704
        b id(b[0] 40845704
        b after a.append() [[1, 2, 3, 4], [4, 5, 6], [7, 8, 9]]
        b after a.append() 40959432
        a after a.append() 40845704
        b after a.append() 40845704
        嵌套的list列表对象使用 copy()方法：发生的是浅拷贝
        最外层的内存地址不一样，里层的内存地址一样，所以 a[0] 发生改变之后，b[0] 也会随之改变。
        -- 这里理解了。
        
    """

    # 列表对象的深拷贝与修改
    # a = [1, 2, 3]
    # b = copy.deepcopy(a)
    # print("a by id[a]", id(a))
    # print("b by id[b]", id(b))
    # print("a by id[0]", id(a[0]))
    # print("b by id[0]", id(b[0]))
    # b[0] = 4
    # print("a after by a[0]", id(a[0]))
    # print("b after by b[0] = 4", id(b[0]))
    # print("b by id[b]", id(b))

    """
        a by id[a] 40587848
        b by id[b] 40587784
        a by id[0] 506030848
        b by id[0] 506030848
        a after by a[0] 506030848
        b after by b[0] = 4 506030944
        b by id[b] 38224456
        
        a = [1, 2, 3] ： 变量a是一个列表
        b = copy.deepcopy(a) ： 
            对列表进行深拷贝操作，所以变量a 和 变量b 在内存中的地址是不一样的
        a[0] 和 b[0] 的内存地址一样的原因：
            这里还不明白。
            因为 a[0] 和 b[0] 两者之间是相等的，所以指向的是同一个内存地址。
            
        b[0] = 4： 
            对b列表中的元素进行修改，因为值为4是一个int型的数据结构，所以b[0] = 4 的修改操作是一个不可变类型的操作
            因此这里发生了一个拷贝动作，申请了新的一个内存地址，所以 b[0] 的内存地址发生了变化。
          
    """