import re



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
