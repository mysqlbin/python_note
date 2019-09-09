#!/usr/local/bin/python3
#coding=utf-8


# 默认用户输入以逗号相隔的两个整型数字,将其提取后,做后续的操作



#场景1
"""
如果输入 a,b
    程序会抛出异常: Value Error: invalid literal for int() with base 10: 'a'   #说明输入的 'a' 这个值不是整型
    然后跳出 try 这个 block.
    由于程序抛出的异常类型是 ValueError, 和 except block 所 catch的异常类型相匹配
        所以 except block便会被执行
        最终输出 Value Error: invalid literal for int() with base 10: 'a' 并打印出 continue;
"""

try:
    s = input('please enter two numbers separated by comma: ')
    num1 = int(s.split(',')[0].strip())
    num2 = int(s.split(',')[1].strip())
    print('输入的值为 {} 和 {}'.format(num1, num2))
except ValueError as err:
    print('Value Error: {}'.format(err))

print('continue')


########## 输出下面注释的内容 ##############
"""
please enter two numbers separated by comma: a,b
Value Error: invalid literal for int() with base 10: 'a'
continue
"""

# 说明 except block 只接受与它相匹配的异常类型并执行,
# 如果程序抛出的异常并不匹配, 那么程序照样会终止退出.


#场景2
"""
    如果输入 1
    抛出的异常是 IndexError: list index out of range
    与 ValueError 不匹配, 那么  excepe block 就不会被执行, 程序便会终止并退出
    并且  continue 不会被打印
"""

########## 输出下面注释的内容 ##############
"""
please enter two numbers separated by comma: 1
num2 = int(s.split(',')[1].strip())
IndexError: list index out of range
"""


#这个例子说明: 强调一种类型的写法有很大的局限性


#解决方案
# 1. 在 except block中加入多种异常的类型
    # 在每次程序执行时, except block 中只要有一个 exception 类型与实际匹配即可.
# 写法1

try:
    s = input('please enter two numbers separated by comma: ')
    num1 = int(s.split(',')[0].strip())
    num2 = int(s.split(',')[1].strip())
    print('输入的值为 {} 和 {}'.format(num1, num2))
except (ValueError, IndexError) as err:
    print('Error: {}'.format(err))
print('continue')


### 输入值 1 ###
### 输出 ###
please enter two numbers separated by comma: 1
Error: list index out of range
continue

### 输入值 1, b ###
### 输出 ###
Error: invalid literal for int() with base 10: 'b'
continue


# 写法2

try:
    s = input('please enter two numbers separated by comma: ')
    num1 = int(s.split(',')[0].strip())
    num2 = int(s.split(',')[1].strip())
    print('输入的值为 {} 和 {}'.format(num1, num2))
except IndexError as err:
    print('IndexError: {}'.format(err))
except ValueError as err:
    print('ValueError: {}'.format(err))

print('continue')

### 输入值 1 ###
### 输出 ###
IndexError: list index out of range
continue

### 输入值 1, b ###
### 输出 ###
ValueError: invalid literal for int() with base 10: 'b'
continue


"""
输入值: 1
IndexError: list index out of range
continue
"""


#很多时候, 我们很难保证程序覆盖所有的异常类型
# 更通常的做法是在最后一个 except block 声明其处理的异常类型是 Exception
# Exception 是其他所有非系统异常的基类, 能够匹配任意非系统异常.

#写法1:

try:
    s = input('please enter two numbers separated by comma: ')
    num1 = int(s.split(',')[0].strip())
    num2 = int(s.split(',')[1].strip())
    print('输入的值为 {} 和 {}'.format(num1, num2))
except IndexError as err:
    print('IndexError: {}'.format(err))
except ValueError as err:
    print('ValueError: {}'.format(err))
except Exception as err:
    print('Other error: {}'.format(err))
print('continue')



"""
#独立测试 Exception
try:
    s = input('please enter two numbers separated by comma: ')
    num1 = int(s.split(',')[0].strip())
    num2 = int(s.split(',')[1].strip())
    print('输入的值为 {} 和 {}'.format(num1, num2))
except Exception as err:
    print('Other error: {}'.format(err))
print('continue')
"""
"""
please enter two numbers separated by comma: a, b
Other error: invalid literal for int() with base 10: 'a'
continue
"""


#写法2:
#也可以在 except 后面省略异常类型， 表示与任意异常匹配（包括系统异常等）

try:
    s = input('please enter two numbers separated by comma: ')
    num1 = int(s.split(',')[0].strip())
    num2 = int(s.split(',')[1].strip())
    print('输入的值为 {} 和 {}'.format(num1, num2))
except IndexError as err:
    print('IndexError: {}'.format(err))
except ValueError as err:
    print('ValueError: {}'.format(err))
except:
    print('Other error')
print('continue')




"""
    多个 except block, 最多只有一个 except block会被执行
    如果多个 except声明的异常类型都与实际相匹配,那么只有最前面的 except block会被执行, 其它 except则被忽略.

    finally 经常和 try except放在一起使用,
        无论发生什么情况, finally block 中的语句都会被执行
            即使前面的 try 和 except block中使用了 return 语句.
"""



"""
# 在文件读取的场景中使用 finally
"""

import sys
try:
    f = open('file.txt', 'r')

except OSError as err:
    print('OS error: {}'.format(err))
except:
    print('Unexpected error:', sys.exc_info()[0])
finally:
    f.close()

"""
分析：
try block 尝试读取 file.txt 这个文件，并对其中的数据进行一系列的处理；
到最后，无论是读取成功还是读取失败， 程序都会执行 finally 中的语句；
	作用：关闭这个文件流， 确保文件的完整性。	

"""


try:
    data = json.loads(raw_data)
    ....
except JSONDecodeError as err:
    print('JSONDecodeError: {}'.format(err))




if 'dob' in d:
    value = d['dob']
    ...
