

# class MyClass:
#     """ 一个简单的类实例 """
#     i = 123456
#     def f(self):
#         return 'hello world'
#
# # 实例类
# x = MyClass()
#
# # 访问类的属性和方法
# print("MyClass 类的属性 i 为：", x.i)
# print("MyClass 类的方法 f 输出为：", x.f())

"""

MyClass 类的属性 i 为： 123456
MyClass 类的方法 f 输出为： hello world

"""

print("..........................................")


# 通过在属性或者方法前面加上两个下划线 __，就可以声明私有属性以及私有方法
# 私有属性和私有方法，在类的外部是不能够被访问的
# class MyClass:
#     """一个简单的类实例"""
#     __i = 12345
#
#     def __f(self):
#         return 'hello world'
#
# # 实例化类
# x = MyClass()
# # 访问类的属性和方法
# print("MyClass 类的属性 i 为 ", x.__i)
# print("MyClass 类的方法 f 输出为：", x.__f())

# AttributeError: 'MyClass' object has no attribute '__i'

print("..........................................")


class MyClass:
    """ 一个简单的类实例 """
    i = 123456
    def f(self):
        print("in class type", type(self))
        print("in class id ", id(self))

# 实例化类
x = MyClass()
x.f()
print("out class type", type(x))
print("out class id", id(x))


y = MyClass()
y.f()

# self 代表类的实例。   -- 算是明白了。


print("..........................................")

class ZstClass:
    def __init__(self):
        print("zst class init")

# 实例化类
ZstClass()
