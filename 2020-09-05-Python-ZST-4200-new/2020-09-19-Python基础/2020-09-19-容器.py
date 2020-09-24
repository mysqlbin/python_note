

if __name__ == '__main__':


    # Defaultdict
    # 作用：该例子统计strings/元组中某个单词出现的次数，并在counts字典中作记录。
    strings = ('puppy', 'kitten', 'puppy', 'puppy', 'weasel', 'puppy', 'kitten', 'puppy')

    counts = {}
    for kw in strings:
        if kw not in counts:
            counts[kw] = 1
    else:
        counts[kw] += 1
        # counts[kw] = counts[kw] + 1

    print(counts)


    from collections import defaultdict

    strings = ('puppy', 'kitten', 'puppy', 'puppy',
               'weasel', 'puppy', 'kitten', 'puppy')

    counts = defaultdict(lambda: 0)  # 使用lambda来定义简单的函数
    for s in strings:
        counts[s] += 1
    print(counts)

    for k in counts:
        print(k, counts[k])

    print(".....................")

    # Counter
    # 作用：用来做计算器, 一行代码实现可迭代数据类型的统计。

    from collections import Counter

    # 统计字符串中每个字母出现的次数
    # c = Counter()
    # for ch in 'programing':
    #     c[ch] = c[ch] + 1
    # print(c)
    # Counter({'r': 2, 'g': 2, 'p': 1, 'o': 1, 'a': 1, 'm': 1, 'i': 1, 'n': 1})

    c = Counter('programing')
    print(c)
    # Counter({'r': 2, 'g': 2, 'p': 1, 'o': 1, 'a': 1, 'm': 1, 'i': 1, 'n': 1})

    # 统计列表中每个元素出现的次数
    c = Counter([2, 3, 5, 3, 2, 3, 3])
    print(c)
    # Counter({3: 4, 2: 2, 5: 1})

    # 统计元组中每个元素出现的次数
    strings = ('puppy', 'kitten', 'puppy', 'puppy',
               'weasel', 'puppy', 'kitten', 'puppy')
    c = Counter(strings)
    print(c)
    # Counter({'puppy': 5, 'kitten': 2, 'weasel': 1})

    print(".....................")

    # Deque
    from collections import deque
    l = deque()
    for i in range(10):
        l.appendleft(i)
    print(l)
    l.popleft()
    print(l)
