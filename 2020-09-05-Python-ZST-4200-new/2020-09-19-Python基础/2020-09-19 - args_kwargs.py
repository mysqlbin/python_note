
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

def aaa(**kwargs):
    print(kwargs)

if __name__ == '__main__':

    print(".....................")


    aaa(a=1, b=2)

    print(".....................")

    weather('zst', '20200919')
    """
    zst
    20200919
    ()
    <class 'tuple'>
    {}
    <class 'dict'>
    """

    print(".....................")
    weather(name='zst', time='20200919')
    """
    zst
    20200919
    ()
    <class 'tuple'>
    {}
    <class 'dict'>
    """

    print(".....................")
    weather("1", "2")
    """
    1
    2
    ()
    <class 'tuple'>
    {}
    <class 'dict'>
    """

    print(".....................")
    weather('zst', '20200919', "a", "b", "cde")
    """
    zst
    20200919
    ('a', 'b', 'cde')
    <class 'tuple'>
    {}
    <class 'dict'>
    """

    print(".....................")
    weather('zst', '20200919', "a", "b", "cde", k=1, v=3)
    """
    zst
    20200919
    ('a', 'b', 'cde')
    <class 'tuple'>
    {'k': 1, 'v': 3}
    <class 'dict'>
    """

    print(".....................")
    week('zst', '20200919', "a", "b", "cde", k=1, v=3)
    """
    ('zst', '20200919', 'a', 'b', 'cde')
    {'k': 1, 'v': 3}
    """