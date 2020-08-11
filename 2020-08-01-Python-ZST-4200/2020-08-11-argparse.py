import argparse
import sys

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="这是一个仿mv命令行程序")
    parser.add_argument("source", help="源文件")
    parser.add_argument("dest", help="目标文件")
    parser.add_argument("-S", "--suffix", choices=['a', 'b', 'c'], default='b')
    parser.add_argument("-f", "--force", action='store_true')   # 结果为布尔值，如果命令行有添加 -f 参数，那么为 True，否则为 False
    parser.add_argument("-v", "--verbose", action='count')   # -vvv

    args = parser.parse_args()   # 命令行参数解析方法
    print(args)

    print("source: {}".format(args.source))
    print("dest: {}".format(args.dest))
    print("suffix: {}".format(args.suffix))
    print("force: {}".format(args.force))
    print("verbose: {}".format(args.verbose))

    print(sys.argv[1:])

"""
E:\github\python_note\venv\Scripts\python.exe E:/github/python_note/2020-08-01-Python-ZST-4200/2020-08-11.py a.txt b.txt -S=a -vvv
Namespace(dest='b.txt', force=False, source='a.txt', suffix='a', verbose=3)
source: a.txt
dest: b.txt
suffix: a
force: False
verbose: 3
['a.txt', 'b.txt', '-S=a', '-vvv']
"""