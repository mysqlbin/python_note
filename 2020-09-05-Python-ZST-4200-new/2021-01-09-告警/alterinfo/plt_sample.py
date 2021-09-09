
import numpy as np
import matplotlib.pyplot as plt

# np.random.seed(2)
# y = np.random.random(10)
# print(y)
# z = np.random.random(10)
# print(z)
# x = range(len(y))
#
# plt.grid()  # 网格
# plt.plot(y, c='g', linewidth=1.5, label='plot 1')  # 折线图
#
# plt.xlabel('x')  # 设置x轴标签
# plt.ylabel('y')  # 设置y轴标签
#
# plt.xlim(-1, 10)  # 设置x轴的范围
# plt.ylim(0, 1)  # 设置y轴的范围
#
# plt.scatter(x, y, marker='o', c='r')  # 散点
# plt.legend()  # 图例
#
# plt.title('matplotlab')  # 设置标题
#
# plt.show()


# x = np.linspace(-1, 1, 50)  # 从(-1,1)均匀取50个点
# y = 2 * x
#
# plt.plot(x, y)
# plt.show()


np.random.seed(2)
y = np.random.random(10)
print(y)
x = range(len(y))
print(x)


"""
[0.4359949  0.02592623 0.54966248 0.43532239 0.4203678  0.33033482
 0.20464863 0.61927097 0.29965467 0.26682728]
range(0, 10)
"""

plt.grid()  # 网格
plt.plot(y, c='g')  # 画折线图，颜色为绿色
plt.xlabel('x')  # 设置x轴标签
plt.ylabel('y')  # 设置y轴标签
plt.xticks(x, ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'g'))  # 设置x轴刻度
plt.title('matplotlib')
plt.show()

