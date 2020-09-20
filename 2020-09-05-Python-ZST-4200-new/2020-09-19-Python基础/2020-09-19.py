

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


if __name__ == '__main__':
    # weather('zst', '20200919')
    # weather(name='zst', time='20200919')
    # weather("1", "2")
    # weather('zst', '20200919', "a", "b", "cde")
    weather('zst', '20200919', "a", "b", "cde", k=1, v=3)

    l_a = [1, 2]
    print("l_a before change", l_a, id(l_a))
    l_a.append(3)
    print("l_a after change", l_a, id(l_a))
    for i in range(2):
        l_a.append(i)
    print("l_a after many changes", id(l_a))

    l_b = l_a
    print("l_b", id(l_b))
    print("l_a length before l_b append", l_a, len(l_a))
    l_b.append(1)
    print("l_a length after l_b append", l_a,  len(l_a))
