
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

    print(a)
    f()
    print(a)

    print(".....................")

    l_a = [1, 2]
    print("l_a before change", l_a, id(l_a))
    l_a.append(3)
    print("l_a after change", l_a, id(l_a))
    for i in range(2):
        l_a.append(i)
    print("l_a after many changes", id(l_a))

    # 相当于是别名
    l_b = l_a
    print("l_b", id(l_b))
    print("l_a length before l_b append", l_a, len(l_a))
    l_b.append(1)
    print("l_b length after l_b append", l_a, len(l_b))
    print("l_a length after l_b append", l_a, len(l_a))


    print(".....................")

    a_str = "zst"
    print("a_str before change", a_str, id(a_str))

    a_str = "python"
    print("a_str after change", a_str, id(a_str))

    print(".....................")

    # 可变类型： 在函数内部修改传参的列表，函数外的列表也会发生改变。
    # 传值
    def lfunc(l):
        print("in func", l, id(l))
        l.append(1)
        print("in func append after", l, id(l))
    l = []
    print("out of func", l, id(l))
    lfunc(l)
    print("out of func", l, id(l))

    """
    out of func [] 1535551993992
    in func [] 1535551993992
    in func append after [1] 1535551993992
    out of func [1] 1535551993992
    """
    print(".....................")


    # 不可变类型：在函数内部修改传参的变量，函数外的变量不会发生改变。
    # 不可变类型在函数中传递的变化
    b = 2
    def func(a):
        print("a id", a,  id(a))
        a += 1
        # 数值型是不可变的数据类型，所以 a += 1 实际了开辟了新的一块内存地址。
        print("a after add", a, id(a))
    print("before func", b, id(b))
    func(b)
    print("after func", b, id(b))

    """
    before func 2 1678535456
    a id 2 1678535456
    a after add 3 1678535488
    after func 2 1678535456
    """

    a = 1
    def funct(a):
        print(a)

    funct(a)

    # 明白 str 跟 bytes 的互相转换
    a_str = "我a中国字"
    # str 转换为  bytes
    print(a_str.encode('utf-8'))
    #    bytes 转换为 str
    print(a_str.encode('utf-8').decode('utf-8'))
    # bytes的表达方式
    a_bytes = b'abcdf'
    print(a_bytes)

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
    g = lambda x: x ** 2
    print(type(g))
    print(g(2))
    # 多个参数的：
    g = lambda x, y, z: (x + y) ** z
    print(g(1, 2, 3))


    a_str = "abc"
    b_str = "abc"
    print('a_str', id(a_str))
    print('b_str', id(b_str))
    # == 是查看内容是否一样， is 表示内存地址是否一样 id(xx) == id(xx)
    #
    if a_str is b_str:
        print("true")
    else:
        print("false")
    # true

    a_list = ['a', 'b', 'c']
    b_list = ['a', 'b', 'c']
    print("a_list", id(a_list))
    print("b_list", id(b_list))
    if a_list is b_list:
        print("true")
    else:
        print("false")
    # false
