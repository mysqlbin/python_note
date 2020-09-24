

if __name__ == '__main__':
    # 列表对象的直接赋值
    # 单层的list列表对象使用copy()方法 --深拷贝
    # 单层的list列表对象使用copy()方法  --子对象元素的内存地址一样的原因
    # 嵌套的list列表对象使用copy()方法 --浅拷贝
    # 单层的list列表对象使用deepcopy()方法 --深拷贝


    # 列表对象的直接赋值
    # a = [1, 2, 3]
    # b = a
    """
        等价于
            a = [1, 2, 3]
            b = [1, 2, 3]
    """
    # print("a", id(a))
    # print("b", id(b))
    # a.append(4)
    # print("a after a.append()", a)
    # print("b after a.append()", b)
    # print("a after a.append()", id(a))
    # print("b after a.append()", id(b))
    """
        a 2564709685512
        b 2564709685512
        a after a.append() [1, 2, 3, 4]
        b after a.append() [1, 2, 3, 4]
        a after a.append() 2564709685512
        b after a.append() 2564709685512
        
        列表的直接赋值，也是对象的引用。
        
    """

    # 单层的list列表对象使用copy()方法
    a = [1, 2, 3]
    b = a.copy()
    print("a", id(a))
    print("b", id(b))
    print("a by id(a[0])", id(a[0]))
    print("b by id(b[0])", id(b[0]))
    a.append(4)
    print("a after a.append()", a)
    print("b after a.append()", b)
    print("a after by id(a[0])", id(a[0]))
    print("b after by a.append(4)", id(b[0]))
    """
        a 2309244319048
        b 2309244318984
        a by id(a[0]) 1678535424
        b by id(b[0]) 1678535424
        a after a.append() [1, 2, 3, 4]
        b after a.append() [1, 2, 3]
        a after by id(a[0]) 1678535424
        b after by a.append(4) 1678535424
        
        最外层的内存地址不一样
        子对象的内存地址一样，但是列表a发生修改后，列表b并没有发生改变。 
            --这个是为什么？ 列表不是可修改的吗，按正常逻辑，列表a发生修改后，列表b也会发生改变。
            [1, 2, 3] 分为两层的话：
                最外层的[]是第一层--即父对象
                1, 2, 3是里层--子对象，不可变的数据类型
                所以 a.append(4) 操作：修改的是不可变的数据类型，修改前需要拷贝 1, 2, 3 出来，然后才可以对变量a进行修改。
        小结
            拷贝：
                分为父对象、子对象
                拷贝之后的修改：要区分可变的数据类型和不可变的数据类型       
    """

    # 单层的list列表对象使用copy()方法  --子对象元素的内存地址一样的原因
    # a = [1, 2, 3]
    # b = a.copy()
    # print("a by id(a)", id(a))
    # print("b by id(b)", id(b))
    # print("a by id(a[0])", id(a[0]))
    # print("b by id(b[0])", id(b[0]))
    # b[0] = 4
    # print("a after by id(a[0])", id(a[0]))
    # print("b after by b[0] = 4", id(b[0]))
    # print("b by id[b]", id(b))

    """
        a by id(a) 2557690639816
        b by id(b) 2557690639880
        a by id(a[0]) 1678535424
        b by id(b[0]) 1678535424
        a after by id(a[0]) 1678535424
        b after by b[0] = 4 1678535520
        b by id[b] 2557690639880

        b[0] = 4： 
            [1, 2, 3] 分为两层的话：
                最外层的[]是第一层--即父对象
                1, 2, 3是里层--子对象，不可变的数据类型, b[0] = 4 的修改操作是一个不可变类型的操作, 申请了新的一个内存地址，所以 b[0] 的内存地址发生了变化。
                -- 理解了。
    """

    # 嵌套的list列表对象使用copy()方法
    # a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    # b = a.copy()
    # print("a", id(a))
    # print("b", id(b))
    # print("a id(a[0])", id(a[0]))
    # print("b id(b[0])", id(b[0]))
    # a[0].append(4)
    # print("b after a.append()", b)
    # print("b after a.append() id(b)", id(b))
    # print("a after a.append()", id(a[0]))
    # print("b after a.append()", id(b[0]))

    """
        a 2799826564488
        b 2799826564680
        a id(a[0]) 2799826564424
        b id(b[0]) 2799826564424
        b after a.append() [[1, 2, 3, 4], [4, 5, 6], [7, 8, 9]]
        b after a.append() id(b) 2799826564680
        a after a.append() 2799826564424
        b after a.append() 2799826564424
        
        最外层(父对象)的内存地址不一样，里层(子对象)的内存地址一样
        执行 a[0].append(4) 操作，因为 a[0] 是一个子对象并且是一个列表，所以是可变的数据类型， 因此 b[0] 也会随之改变。
        小结：
            嵌套的list列表对象使用 copy()方法：发生的是浅拷贝
            
    """

    # 单层的list列表对象使用deepcopy()方法
    # import copy
    # a = [1, 2, 3]
    # b = copy.deepcopy(a)
    # print("a by id(a)", id(a))
    # print("b by id(b)", id(b))
    # print("a by id(a[0])", id(a[0]))
    # print("b by id(b[0])", id(b[0]))
    # b[0] = 4
    # print("a after by id(a[0])", id(a[0]))
    # print("b after by b[0] = 4", id(b[0]))
    # print("b by id[b]", id(b))

    """
         
        a by id(a) 2616071204680
        b by id(b) 2616072507528
        a by id(a[0]) 1678535424
        b by id(b[0]) 1678535424
        a after by id(a[0]) 1678535424
        b after by b[0] = 4 1678535520
        b by id[b] 2616072507528
        
        a = [1, 2, 3] ： 变量a是一个列表
        b = copy.deepcopy(a) ： 
            对列表进行深拷贝操作，所以变量a 和 变量b 在内存中的地址是不一样的
            
        a[0] 和 b[0] 的内存地址一样的原因：
        
            因为 a[0] 和 b[0] 两者之间是相等的，所以都是同一个内存地址指向这个 1 这个元素。
            
        b[0] = 4： 
            [1, 2, 3] 分为两层的话：
                最外层的[]是第一层--即父对象
                1, 2, 3 是里层--子对象，不可变的数据类型, b[0] = 4 的修改操作是一个不可变类型的操作, 申请了新的一个内存地址，所以 b[0] 的内存地址发生了变化。

          
    """


