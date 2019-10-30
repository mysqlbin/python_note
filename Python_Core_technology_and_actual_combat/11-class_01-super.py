#!/usr/local/bin/python3
#coding=utf-8

#类继承

class Entity():
    def __init__(self, object_type):
        print('parent class init called')
        self.object_type = object_type

    def get_context_length(self):
        raise Exception('get_context_length not implemente')      #用户定义异常

    def print_title(self):
        print(self.title)

class Document(Entity):
    def __init__(self, title, author, context):       # 作为参数进行传递
        print('Document class init called')
        Entity.__init__(self, 'document')            # 自定义构造函数，在 init() 函数中显示调用父类的构造函数
        self.title = title
        self.author = author
        self.__context = context

    def get_context_length(self):
        return len(self.__context)

class Video(Entity):
    def __init__(self, title, author, video_length):
        print('Video class init called')
        Entity.__init__(self, 'video')
        self.title = title
        self.author = author
        self.__video_length = video_length

    def get_context_length(self):
        return self.__video_length

harry_potter_book = Document('Harry Potter(Book)', 'J. K. Rowling',
                             '... Forever Do not believe any thing is capable of thinking independently ...')
harry_potter_movie = Video('Harry Potter(Movie)', 'J. K. Rowling', 120)

# 输出
"""
Document class init called
parent class init called
Video class init called
parent class init called
"""

# 子类可以继承了父类的构造函数
# print(harry_potter_book.object_type)
# print(harry_potter_movie.object_type)
"""
document
video
"""

# entity = Entity('a')
# print(entity)
# print(entity.get_context_length())   #Exception: get_context_length not implemente

# 子类可以继承父类的行为
# harry_potter_book.print_title()
# harry_potter_movie.print_title()

"""
Harry Potter(Book)
Harry Potter(Movie)
"""

# 子类可以重写父类的行为
# print(harry_potter_book.get_context_length())
# print(harry_potter_movie.get_context_length())
"""
77
120
"""


########## 输出 ##########
"""
Document class init called
parent class init called
Video class init called
parent class init called
document
video
Harry Potter(Book)
Harry Potter(Movie)
77
120
"""

"""
类的继承：
    一个类拥有另一个类的特性， 也拥有不同于另一个类的独特特征， 第一个类叫做子类，另一个叫做父类
    子类拥有父类的特征，也拥有不同于父类的特征
    特征：其实就是类的属性和函数。

Document 和 Video 这两个类有相似的地方：
    相应的标题、作者、和内容等属性
    因此，可以从中抽象出一个叫做 Entity的类， 作为 这两个类的父类

类的构造函数：
    每个类都有构造函数
    继承类在生成对象的时候， 要在 init()函数中显示调用父类的构造函数
        Entity.__init__(self, 'document')
        Entity.__init__(self, 'video')
    执行顺序：
        子类的构造函数 -> 父类的构造函数

函数重写：
    函数重写是一种很好的写法
    函数重写，可以使子类必须重写一遍函数，来覆盖原有函数；

    父类 Entity.get_context_length()函数：
       如果使用Entity直接生成对象，调用 get_context_length()函数，就会 raise error中断程序的执行


继承的优势：
    减少重复的代码，降低系统的复杂度
    代码体现：
        父类 Entity.print_title() 函数， 子类的对象可以豪无阻力地使用它来打印 title

"""


