#!/usr/bin/ptyhon
#coding=gbk

# str ����
s = 'RUNOOB'
print(s)

dict = {'runoob': 'runoob.com', 'google': 'google.com'}
print(type(dict))
print(type(str(dict)))
print(str(dict))

# list ����
print(list('abc'))

print(list([1, 2, 3]))

print(list({1: 2, 3: 4}))

# tuple ����
print(tuple('abc'))

print(tuple([1, 2, 3]))

print(tuple(['a', 'b', 3]))

# set ����
print(set([1, 2, 3, 4, 5, 5, 4, 3]))


# len ����
strs = 'abc'
# print(len(strs))

lists = [1, 2, 3, 4, 5]
# print(len(lists))

tuples = ('a', 2, 'b', 4)
# print(len(tuples))

# max ����
print('max: {}'.format(max(lists)))
tuples = (2, 3, 4)
print('max: {}'.format(max(tuples)))

# min ����
print('min: {}'.format(min(lists)))
print('min: {}'.format(min(tuples)))

# isinstance ����
str_tag = 'abc'
if isinstance(str_tag, str):
    print(111)

