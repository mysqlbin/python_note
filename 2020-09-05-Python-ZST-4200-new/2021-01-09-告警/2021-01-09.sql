
django-admin startapp alertinfo


matplotlib相关参考
	https://www.runoob.com/python/python-email.html
	https://zhuanlan.zhihu.com/p/46890207
	https://blog.csdn.net/weixin_40683253/article/details/87376085    Matplotlib - 折线图 plot() 所有用法详解


	http://www.srcmini.com/30789.html  numpy.asarray()函数


https://www.cnblogs.com/luck666/p/10219464.html                  在linux中安装字体
https://blog.csdn.net/wangxintong_1992/article/details/81194896  在linux中安装字体


pipenv install numpy
pipenv install matplotlib



windows
pip install numpy
pip --default-timeout=3600 install numpy
pip install matplotlib
pip --default-timeout=3600 install matplotlib




['2021-01-10', '2021-01-11', '2021-01-12', '2021-01-13', '2021-01-14']
counts = [4, 12, 36, 32, 212]

import numpy as np
counts = [4, 12, 36, 32, 212]
print(np.asarray(counts))
[  4  12  36  32 212]


返回具有与序列等效值的数组。




SELECT
	(
		DATE_FORMAT(ts_min, '%Y-%m-%d')
	) AS `byday`,
	SUM(
		`mysql_slow_query_review_history`.`ts_cnt`
	) AS `date_count`
FROM
	`mysql_slow_query_review_history`
WHERE
	`mysql_slow_query_review_history`.`ts_min` BETWEEN '2020-10-23 00:00:00'
AND '2021-01-22 23:59:59'
GROUP BY
	(
		DATE_FORMAT(ts_min, '%Y-%m-%d')
	)
ORDER BY
	`byday` ASC;



https://www.pythonf.cn/read/10332          RuntimeWarning: Glyph 24930 missing from current font.
https://www.yuque.com/fcant/python/ptzo53  Linux环境下Matplotlib绘图乱码问题


	>>> matplotlib.get_cachedir()
	'/home/vagrant/.cache/matplotlib'

	rm -rf /home/vagrant/.cache/matplotlib



celery 定时器


#crontab任务
#每周一7:30调用task.add
from celery.schedules import crontab

CELERYBEAT_SCHEDULE = {
    # Executes every Monday morning at 7:30 A.M
    'add-every-monday-morning': {
        'task': 'tasks.add',
        'schedule': crontab(hour=7, minute=30, day_of_week=1),
        'args': (16, 16),
    },
}


