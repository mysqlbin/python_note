#!/usr/bin/ptyhon
#coding=gbk

"""
"""

count = 5
while count > 0:
    count = count - 1
    if count == 3:
        continue
    print('���ݿ�ͱ��ÿ�����һ���,count: {}'.format(count))

"""
count = 5 ����0��count��1�����4��������3�� ��� ���ݿ�ͱ��ÿ�����һ���,count: 4
count = 4 ����0��count��1�����3�� �������ѭ��
count = 3 ����0��count��1�����2��������3�� ���ݿ�ͱ��ÿ�����һ���,count: 2
count = 2 ����0��count��1�����1��������3�� ���ݿ�ͱ��ÿ�����һ���,count: 1
count = 1 ����0��count��1�����0��������3�� ���ݿ�ͱ��ÿ�����һ���,count: 0
0 ������ 0������ѭ������
"""

