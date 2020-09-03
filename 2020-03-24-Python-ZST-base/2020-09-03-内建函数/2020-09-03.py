#!/usr/bin/ptyhon
#coding=gbk

# str 函数
s = 'RUNOOB'
print(s)

dict = {'runoob': 'runoob.com', 'google': 'google.com'}
print(type(dict))
print(type(str(dict)))
print(str(dict))

# list 函数
print(list('abc'))

print(list([1, 2, 3]))

print(list({1: 2, 3: 4}))

# tuple 函数
print(tuple('abc'))

print(tuple([1, 2, 3]))

print(tuple(['a', 'b', 3]))

# set 函数
print(set([1, 2, 3, 4, 5, 5, 4, 3]))


# len 函数
strs = 'abc'
# print(len(strs))

lists = [1, 2, 3, 4, 5]
# print(len(lists))

tuples = ('a', 2, 'b', 4)
# print(len(tuples))

# max 函数
print('max: {}'.format(max(lists)))
tuples = (2, 3, 4)
print('max: {}'.format(max(tuples)))

# min 函数
print('min: {}'.format(min(lists)))
print('min: {}'.format(min(tuples)))

# isinstance 函数
str_tag = 'abc'
if isinstance(str_tag, str):
    print(111)

