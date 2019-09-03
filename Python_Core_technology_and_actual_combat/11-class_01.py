#!/usr/local/bin/python3
#coding=utf-8

#Python 面向对象
"""
class Document:
    def __init__(self):
        print('init function called')

print(Document())
"""

"""
#输出下面的内容
init function called
<__main__.Document object at 0x000000000275A2B0>
# 即初始化的时候自动加载
"""

#一个基础类
"""
class Document():
    def __init__(self, title, author, context):
        print('init function called')
        self.title = title
        self.author = author
        self.__context = context # __ 开头的属性是私有属性

    def get_context_length(self):
        return len(self.__context)

    def intercept_context(self, length):
        self.__context = self.__context[:length]

harry_potter_book = Document('Harry Potter', 'J. K. Rowling', '... Forever Do not believe any thing is capable of thinking independently ...')

print(harry_potter_book.title)
print(harry_potter_book.author)
print(harry_potter_book.get_context_length())
print(harry_potter_book.intercept_context(10))
print(harry_potter_book.__context)
"""

<<<<<<< HEAD:python_study/python_note/Python_Core_technology_and_actual_combat/11-class_01.py
"""
init function called
Harry Potter
J. K. Rowling
77
None
AttributeError: 'Document' object has no attribute '__context'
"""

"""
class Document 定义了 Document 类。

Document 类的三个函数
__init__
    表示构造函数，意即一个对象生成时会被自动调用的函数。
    harry_potter_book = Document(...) 这一行被执行的时候, 'init function called' 字符串会被打印出来

get_context_length() 和 intercept_context() 则为类的普通函数，我们调用它们来对对象的属性做一些事情。

Document 类的三个属性:
    title、author 和 __context 分别表示标题、作者和内容，通过构造函数传入。
     intercept_context 能修改对象 harry_potter_book 的 __context 属性。
     私有属性:
        概念:
            是指不希望在类的函数之外的地方被访问和修改的属性
            title 和 author 能够很自由地被打印出来
            print(harry_potter_book.__context) 会报错
        定义:
            如果一个属性以 __ （注意，此处有两个 _） 开头，我们就默认这个属性是私有属性。
=======
"""
init function called
Harry Potter
J. K. Rowling
77
None
AttributeError: 'Document' object has no attribute '__context'
"""

"""
class Document 定义了 Document 类。

Document 类的三个函数
__init__
    表示构造函数，意即一个对象生成时会被自动调用的函数。
    harry_potter_book = Document(...) 这一行被执行的时候, 'init function called' 字符串会被打印出来

get_context_length() 和 intercept_context() 则为类的普通函数，我们调用它们来对对象的属性做一些事情。

Document 类的三个属性:
    title、author 和 __context 分别表示标题、作者和内容，通过构造函数传入。
     intercept_context 能修改对象 harry_potter_book 的 __context 属性。
     私有属性:
        概念:
            是指不希望在类的函数之外的地方被访问和修改的属性
            title 和 author 能够很自由地被打印出来
            print(harry_potter_book.__context) 会报错
        定义:
            如果一个属性以 __ （注意，此处有两个 _） 开头，我们就默认这个属性是私有属性。

"""
>>>>>>> 3f65f3e1f871bbfdcf3ff8f5b63fb5b69039f0c3:python_study/python_note/Python_Core_technology_and_actual_combat/11-class_01.py

"""

class Document():
    WELCOME_STR = 'Welcome! The context for this book is {}.'

    def __init__(self, title, author, context):
        print('init function called')
        self.title = title
        self.author = author
        self.__context = context

    # 类函数
    @classmethod
    def create_empty_book(cls, title, author):
        return cls(title=title, author=author, context='nothing')

    # 成员函数
    def get_context_length(self):
        return len(self.__context)

    # 静态函数
    @staticmethod
    def get_welcome(context):
        return Document.WELCOME_STR.format(context)

empty_book = Document.create_empty_book('What Every Man Thinks About Apart from Sex', 'Professor Sheridan Simove')

print(empty_book.get_context_length())
print(empty_book.get_welcome('indeed nothing'))

########## 输出 ##########
"""
init function called
7
Welcome! The context for this book is indeed nothing.
"""

#类继承
"""
class Entity():
    def __init__(self, object_type):
        print('parent class init called')
        self.object_type = object_type

    def get_context_length(self):
        raise Exception('get_context_length not implemente')      #用户定义异常

    def print_title(self):
        print(self.title)

class Document(Entity):
    def __init__(self, title, author, context):
        print('Document class init called')
        Entity.__init__(self, 'document')
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

<<<<<<< HEAD:python_study/python_note/Python_Core_technology_and_actual_combat/11-class_01.py
harry_potter_book = Document('Harry Potter(Book)', 'J. K. Rowling',
                             '... Forever Do not believe any thing is capable of thinking independently ...')
harry_potter_movie = Video('Harry Potter(Movie)', 'J. K. Rowling', 120)
"""
Document class init called
parent class init called
Video class init called
parent class init called
"""

print(harry_potter_book.object_type)
print(harry_potter_movie.object_type)
"""
document
video
"""

=======
entity = Entity('a')
print(entity)
print(entity.get_context_length())   #Exception: get_context_length not implemente
"""
>>>>>>> 3f65f3e1f871bbfdcf3ff8f5b63fb5b69039f0c3:python_study/python_note/Python_Core_technology_and_actual_combat/11-class_01.py

harry_potter_book.print_title()
harry_potter_movie.print_title()
"""
Harry Potter(Book)
Harry Potter(Movie)
"""

print(harry_potter_book.get_context_length())
print(harry_potter_movie.get_context_length())
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


