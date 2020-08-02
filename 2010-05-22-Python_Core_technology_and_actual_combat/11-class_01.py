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

class Document():
    def __init__(self, title, author, context):
        print('init function called')
        self.title = title
        self.author = author
        self.__context = context

    def get_context_length(self):
        return len(self.__context)

    def intercept_context(self, length):
        self.__context = self.__context[:length]


harry_potter_book = Document('Harry Potter', 'J. K. Rowling',
                                 '... Forever Do not believe any thing is capable of thinking independently ...')
print(harry_potter_book.title)
print(harry_potter_book.author)
print(harry_potter_book.get_context_length())
print(harry_potter_book.intercept_context(10))

#  输出
"""
init function called
Harry Potter
J. K. Rowling
77
None
init function called
7
Welcome! The context for this book is indeed nothing.
"""

"""
print(harry_potter_book.__context)
"""
"""
AttributeError: 'Document' object has no attribute '__context'
"""

"""
#　分析
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

