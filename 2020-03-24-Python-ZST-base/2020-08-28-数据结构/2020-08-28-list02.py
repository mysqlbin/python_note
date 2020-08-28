#!/usr/bin/ptyhon
#coding=gbk

a = [2, 8, 1, 33, 43, 9, 3]
b = []
for item in a:
    if item % 2 == 0:
      b.append(item+1)
print(b)

c = []
for index, item in enumerate(a):
    if index % 2 == 0:
        c.append(item+1)
print(c)

for index, item in enumerate(a):
    if index == 3 or index == 5 or index == 6:
        print(item)
