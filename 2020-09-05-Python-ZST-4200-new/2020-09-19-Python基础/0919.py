import re


a = 'a'

def f():
    global a
    a = 'b'
    print(a)

def weather(name, time, *args, **kwargs):
    print(name)
    print(time)
    print(args)
    print(kwargs)
    print(type(kwargs))


def w(*args, **kwargs):
    print(args)
    print(kwargs)

if __name__ == '__main__':
    # 大小写敏感，默认的模式
    # pattern = re.compile(r"abc")
    # m = pattern.match("ABC")
    # if m:
    #     print(m.group())
    # else:
    #     print("not match")

    # 正则忽略大小写
    # pattern = re.compile(r"abc", re.I)
    # m = pattern.match("ABC")
    # if m:
    #     print(m.group())
    # else:
    #     print("not match")

    # 默认是 非多行模式
    # pattern = re.compile(r"^abc", re.I)
    # m = pattern.findall("ABC\nABC")
    # if m:
    #     print(m)
    # else:
    #     print("not match")

    # 使用多行模式 re.M
    # pattern = re.compile(r"^abc", re.I | re.M)
    # m = pattern.findall("ABC\nABC")
    # if m:
    #     print(m)
    # else:
    #     print("not match")

    # . 的默认行为
    # pattern = re.compile(r".", re.I | re.M)
    # m = pattern.findall("ABC123,.\nABC")
    # if m:
    #     print(m)
    # else:
    #     print("not match")

    # re.S来改变'.'的行为
    # pattern = re.compile(r"ABC.*ABC", re.I | re.M | re.S)
    # m = pattern.findall("ABC123,.\nABC")
    # if m:
    #     print(m)
    # else:
    #     print("not match")

    # match方法，从头开始匹配，不一定要把待匹配的文本都用完
    # pattern = re.compile(r"abc", re.I)
    # m = pattern.match("1ABCD")
    # if m:
    #     print(m.string)
    # else:
    #     print("not match")

    # 是希望进行搜索，看看正则是否能匹配到，类似我们在文档中进行的关键词搜索
    # pattern = re.compile(r"\w{2}", re.I)
    # m = pattern.search("-1ABCD-")
    # if m:
    #     print(m.group())
    # else:
    #     print("not match")

    # group()方法, 还可以传入分组的编号
    # pattern = re.compile(r"(\w)(\w)(?P<name>\w)", re.I)
    # m = pattern.search("-1AAABBCCDD-")
    # if m:
    #     print(m.group(0))
    #     print(m.group(1))
    #     print(m.group(2))
    #     print('m.groups()[0]', m.groups()[0])
    #     print('m.groupdict()', m.groupdict()['name'])
    # else:
    #     print("not match")

    # findall方法
    # pattern = re.compile(r"\w\w", re.I)
    # m = pattern.findall("-1AAABBCCDD-")
    # if m:
    #     print(m)
    # else:
    #     print("not match")

    # finditer 方法 iter -> iterator迭代器
    # pattern = re.compile(r"(\w)\w", re.I)
    # m = pattern.finditer("-1AAABBCCDD-")
    # if m:
    #     for s in m:
    #         print(s.group(1))
    # else:
    #     print("not match")

    # 完全匹配 fullmatch
    # pattern = re.compile(r"\d{11}", re.I)
    # m = pattern.fullmatch("1234567890111")
    # if m:
    #     print(m)
    # else:
    #     print("full match failed")

    # 等价于
    # pattern = re.compile(r"^\d{11}$", re.I)
    # m = pattern.match("12345678901111")
    # if m:
    #     print(m)
    # else:
    #     print("not match")
    # print(sum(range(1, 101)))
    # # iterable
    # for i in range(1, 101):
    #     print(i)
    # global
    # f()
    # print(a)

    # l_a = [1, 2]
    # print("l_a before change", l_a, id(l_a))
    # l_a.append(3)
    # print("l_a after change", l_a, id(l_a))
    # for i in range(10000):
    #     l_a.append(i)
    # print("l_a after many changes", id(l_a))
    #
    # l_b = l_a
    # print("l_b", id(l_b))
    # print("l_a length before l_b append", len(l_a))
    # l_b.append(1)
    # print("l_a length after l_b append", len(l_a))
    #
    # a_str = "zst"
    # print("a_str before change", a_str, id(a_str))
    # a_str = "python"
    # print("a_str after change", a_str, id(a_str))
    #weather('zst', '202020919')
    #weather(time='20200919', name='zst')
    #weather("1", "2")
    #weather('zst', '202020919', 's', '2', '3', '4')
    #weather('zst', '202020919', 's', '2', '3', '4', k=1, s=3)
    # def lfunc(l):
    #     print("in func", id(l))
    #     l.append(1)
    # l = []
    # print("out of func", id(l))
    # lfunc(l)
    # print(l)
    #
    # b = 2
    # def func(a):
    #     print("a id", id(a))
    #     a += 1
    #     print("a after add", id(a))
    # print("before func", b, id(b))
    # func(b)
    # print("after func", b)
    #
    # a_str = "我a中国字"
    # print(a_str.encode('utf-8').decode('utf-8'))
    # a_bytes = b'abcdf'
    # print(a_bytes)
    # def use_type(name):
    #     # 希望name是一个字符串
    #     if type(name) != str:
    #         raise Exception("name must be string")
    #     pass
    #
    # use_type(1)

    # def use_isinstance(name):
    #     # 希望name是一个字符串
    #     if not isinstance(name, str):
    #         raise Exception("name must be string")
    #     pass
    # use_isinstance(1)

    # g = lambda x: x ** 2
    # print(type(g))
    # print(g(2))

    # a_str = "abc"
    # b_str = "abc"
    # # == 是查看内容是否一样， is 内存地址是否一样 id(xx) == id(xx)
    # if a_str is b_str:
    #     print("true")
    # else:
    #     print("false")
    #
    # a_list = ['a', 'b', 'c']
    # b_list = ['a', 'b', 'c']
    # if a_list is b_list:
    #     print("true")
    # else:
    #     print("false")
    #元组
    color = [[1,2], [3,4]]
    for i, j in color:
        print(i,j)
    a = 1000
    b = 1000
    print(a is b)
    a = 1
    b = 1
    print(a is b)