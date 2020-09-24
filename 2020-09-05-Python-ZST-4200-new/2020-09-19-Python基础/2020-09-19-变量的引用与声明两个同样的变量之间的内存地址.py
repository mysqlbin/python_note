

if __name__ == '__main__':

    # l_a = [1, 2]
    # l_b = l_a
    #
    # print("l_a", id(l_a))
    # print("l_b", id(l_b))

    """
        l_a 40216712
        l_b 40216712
        l_b = l_a : 这里是直接赋值了，所以两者的内存地址一致。
        
    """

    print(".....................")
    #
    # l_a = [1, 2]
    # l_b = [1, 2]
    #
    # print("l_a", id(l_a))
    # print("l_b", id(l_b))
    """
        l_a 37136520
        l_b 37166024
        l_a 和 l_b 是两个不同的列表对象，所以它们的内存地址是不一样的。
    """

    print(".....................")
    # a_str = "abc"
    # b_str = "abc"
    # print('a_str', id(a_str))
    # print('b_str', id(b_str))
    """
        a_str 36523064
        b_str 36523064
        这个是因为字符串的intern机制导致的。
        简单来说就是同一个字符串分别赋值给不同的变量，他们的内存地址都是相同的。
    """

    print(".....................")

    a_str = "abc"
    b_str =  a_str
    print('a_str', id(a_str))
    print('b_str', id(b_str))
    """
        a_str 36785208
        b_str 36785208
        b_str = a_str : 这里是直接赋值了，所以两者的内存地址一致。
    """
