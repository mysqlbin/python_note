#!/usr/bin/ptyhon
#coding=gbk


# Python�б�߼��÷�:  �б��Ƶ�ʽ
# û�� else
# ��Ŀ1�� �г�10���ڵ�ż��
# s = [x for x in range(0, 10) if x % 2 == 0]
# print(s)

# ��Ŀ2����1��100����ͬʱ����2��3����
# s = [x for x in range(1, 101) if x % 2 == 0 or x % 3 == 0]
# print(s)

# �� else
# ��Ŀ3: ��10���ڵ�����ƽ����ż������
# import math
# s = [math.pow(item, 2) if item % 2 == 1 else item / 2 for item in range(0, 10)]
# print(s)

# ��Ŀ4
"""
�б���ϰ�⣺
a = [1, 3, 4, 5, 8, 'love']
1�� ��������������1������� ������ַ����� ��ֱ�����
2�� ���������λ�������������������1��������ַ�������ֱ�����

"""
a = [1, 3, 4, 5, 8, 'love']
# s = [item + 1 if type(item) == int else item for item in a]
# print(s)

s = [item + 1 if type(item) == int and item % 2 == 1 else item for item in a]
print(s)


# for item in range(0, 3):
#     print(item)

# range(0, 10) ��ʾ 0-9������

"""

������ѭ���Ľ��ײ���
    ��������ѭ������һ�еĲ�����
      �� else���
      expression1 if condition else expression2 for item in iterable
        �ȼ���
        
        for item in iterable:
            if condition:
                expression1
            else:
                expression2
    
      û��else���
       expression for item in iterable if condition
         �ȼ���
        for item in iterable:
            if condition:
                expression

"""

