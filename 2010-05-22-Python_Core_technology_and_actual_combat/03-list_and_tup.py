#!/usr/local/bin/python3
#coding=utf-8


# 列表和元组都是有序集合；

list_07 = [1, 2, 3, 4]
tup_08 = (1, 2, 3, 4)
print(list_07[0])
print(tup_08[0])



"""
list = [1, 2, 'hello', 'world'] # 列表中同时含有 int 和 string 类型的元素
print(list)
tup = ('jason', 22) # 元组中同时含有 int 和 string 类型的元素
print(tup)

list = [1,2,3,4]
list[3]=40             # 和很多语言类似，python 中索引同样从 0 开始，l[3] 表示访问列表的第四个元素
print(list)
# [1, 2, 3, 40]

tup = (1, 2, 3, 4)
tup[3] = 40
print(tup)

tup = (1, 2, 3, 4)
new_tup = tup + (5, ) # 创建新的元组 new_tup，并依次填充原元组的值
print(new_tup)
(1, 2, 3, 4, 5)

list = [1, 2, 3, 4]
list.append(5) # 添加元素 5 到原列表的末尾
print(list)

list = [1, 2, 3, 4]
list[-1]              #负数索引， -1表示最后一个元素，-2表示倒数第二个元素，依次类推
print(list)

tup = (1, 2, 3, 4)
tup[-1]
print(tup)
"""

"""
#切片
list = [1,2,3,4]
list = list[1:3]  # 返回列表中索引从 1 到 2 的子列表
print(list)
list = [1,2,3,4]
list = list[3:4]   # 返回列表中索引从 1 到 2 的子列表
print(list)
list = [1,2,3,4]
list = list[1:4]   # 返回列表中索引从 1 到 2 的子列表
print(list)

tup = (1, 2, 3, 4)
tup = tup[1:3] # 返回元组中索引从 1 到 2 的子元组
print(tup)

#嵌套
list = [[1, 2, 3], [4, 5]] # 列表的每一个元素也是一个列表
print(list)
print(list[0])
print(list[1])

tup = ((1, 2, 3), (4, 5, 6)) # 元组的每一个元素也是一元组
print(tup)
print(tup[0])
print(tup[1])
"""

"""
#列表和元组可以通过 list() 和 tuple() 函数转换：
#列表转元组
tup = tuple([1,2,3])
print(tup)
#元组转列表
list = list((1,2,3))
print(list)
"""

"""
#内置函数
lists = [3, 2, 3, 7, 8, 1]
all_count = lists.count(3)   #统计 3 这个元素出现的次数
print(all_count)

l = [3, 2, 3, 7, 8, 1]
first_pos = l.index(7)   #统计 7 这个元素第一次出现的索引位置
print(first_pos)

l = [3, 2, 3, 7, 8, 1]
l.reverse()  #把列表的元素原地倒转
print(l)

l = [3, 2, 3, 7, 8, 1]
l.sort()     #把列表的元素升序排序
print(l)


tup = (3, 2, 3, 7, 8, 1)
all_count = tup.count(3)          #统计 3 这个元素出现的次数
print(all_count)

tup_index = tup.index(7)          #统计 7 这个元素第一次出现的索引位置
print(tup_index)

#list = [3, 2, 3, 7, 8, 1]
tup = (3, 2, 3, 7, 8, 1)
a = list(reversed(tup))
print(a)
#TypeError: 'list' object is not callable  说明在命名变量时要注意，应避免和python的函数名、关键字冲突。
#参考： https://blog.csdn.net/lvsehaiyang1993/article/details/80667921

tup = (3, 2, 3, 7, 8, 1)
print(sorted(tup))              #把元组的元素升序排序并生成一个新的列表


#列表支持拼接
squares = [1, 4, 9, 16, 25]
squares += [36, 49, 64, 81, 100]
print(squares)

"""