#!/usr/bin/ptyhon
#coding=gbk


# append
# a = [1]
# a.append('1')
# print(a)
#
# a.append(['2'])
# print(a)
#
# a.append({1: 2})
# print(a)
# print(a[0])
# print(a[1])
# print(a[2])
# print(a[3])

# extend
# a = []
# b = ['1']
# a.extend(b)
# print(a)
# a.extend(a)
# print(a)
# a.extend('m')
# print(a)
#
# a.extend({1: 2})
# print(a)
# a.extend((1, 2))
# print(a)

# �����б�����a��b���ж�a��b�����ݸ����Ƿ���ͬ����ͬ�Ļ�����Ԫ����ӡ���ͬ�Ļ�����Ԫ���ٵ���Ϊһ�����Ԫ�ض���б��С�
# a = [44, 11, 2, 6]
# b = ["i", "love", "python"]
#
# print(len(a))
# print(len(b))
#
# total = 0
# if len(a) == len(b):
#     for item in range(0, len(a)):
#         # print(a[item])
#         total = total + int(a[item])
# else:
#     if len(a) > len(b):
#         a.append(b)
#     else:
#         b.append(a)
# print(a)
# print(b)
# print(total)
#

# remove
# a = ['d', 's', 'j', 's']
# a.remove('s')
# print(a)

# ������ϰ����������Ӱ�ﷴ���ɫɾ������

#
# _input = ["spiderman_1", "captain_1", "superman_1", "Thanos_0", "badzz_0", "doctor_strange_1"]
# _input.remove('badzz_0')
# print(_input)

# _input = ["spiderman_1", "captain_1", "superman_1", "Thanos_0", "doctor_strange_1"]
# for item in _input:
#     # print(item)
#     if item.find('_1') == -1:
#         _input.remove(item)
#
# print(_input)

# new_input = []
# _input = ["spiderman_1", "captain_1", "superman_1", "Thanos_0", "badzz_0", "doctor_strange_1"]
# for item in _input:
#     if item.find('_1') != -1:
#         new_input.append(item)
# print(new_input)

# new_input = []
# _input = ["spiderman_1", "captain_1", "superman_1", "Thanos_0", "badzz_0", "doctor_strange_1"]
# for item in _input:
#     if item.split('_')[1] == '0':
#         continue
#     new_input.append(item)
# print(new_input)

# _input = ["spiderman_1", "captain_1", "superman_1", "Thanos_0", "badzz_0", "doctor_strange_1"]
# for item in _input:
#     if item.split('_')[1] == "0":
#         _input.remove(item)
# print(_input)

# pop

a = ['d', 's', 'j']
# a.pop(1)
# print(a)
# �Ƴ����һ��
a.pop()
print(a)

# �޸��б��Ԫ��
# a = [1, 2, 3, 4, 5]
# a[1] = 5
# print(a)

# sort���б��������޸��б���û�з���ֵ

a = [1, 4, 2, 4]
a.sort()
print(a)
a.sort(reverse=True)
print(a)

a = ['a', 'd', 'c']
a.sort()
print(a)
a.sort(reverse=True)
print(a)

# Python3: TypeError: '<' not supported between instances of 'int' and 'str'
# a = ['q', 'a', 3, 1]
# a.sort()
# print(a)
"""
Python 2.7.5 (default, Apr  2 2020, 13:16:51)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-39)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> a = ['q', 'a', 3, 1]
>>> a.sort()
>>> print(a)
[1, 3, 'a', 'q']

"""

# sorted: ���޸�ԭ���б������µ��б�

# Python3: TypeError: '<' not supported between instances of 'int' and 'str'
# a = ['q', 'a', 3, 1]
# sorted(a)

"""
Python 2.7.5 (default, Apr  2 2020, 13:16:51) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-39)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> a = ['q', 'a', 3, 1]
>>> sorted(a)
[1, 3, 'a', 'q']


"""

