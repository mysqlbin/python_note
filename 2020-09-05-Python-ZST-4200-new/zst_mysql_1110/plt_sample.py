
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
# plt.plot(z, c='b', linewidth=1.5, label='plot 2')  # 折线图
#
# plt.xlabel('x')  # 设置x轴标签
# plt.ylabel('y')  # 设置y轴标签
#
# plt.xlim(-1, 10)  # 设置x轴的范围
# plt.ylim(0, 1)  # 设置y轴的范围
#
# plt.scatter(x, y, marker='o', c='r')  # 散点
# plt.scatter(x, z, marker='s', c='r')  # 散点
# plt.legend()  # 图例
#
# plt.title('matplotlab')  # 设置标题
#
# plt.show()


x = np.linspace(-1, 1, 50)  # 从(-1,1)均匀取50个点
y = 2 * x

plt.plot(x, y)
plt.show()
