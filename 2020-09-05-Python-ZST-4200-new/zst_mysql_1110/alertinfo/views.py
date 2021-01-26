from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse, JsonResponse

import smtplib
from email.mime.text import MIMEText
from django.template.loader import render_to_string
from datetime import datetime
import time
from email.mime.multipart import MIMEMultipart
from email.mime.image import MIMEImage
import numpy as np
import matplotlib.pyplot as plt
from slowquery.models import SlowQuery, SlowQueryHistory
from django.db.models import F, Max, Sum, Value as V
import os
from matplotlib import rcParams
import matplotlib
from pylab import mpl
import json
import logging


# 监控最近1个小时的慢日志，待加入计划任务
def monitor_by_interval(request):

    import datetime
    days = datetime.datetime.now() + datetime.timedelta(hours=-1)
    # days = datetime.datetime.now() + datetime.timedelta(days=-1)
    start_time = days.strftime("%Y-%m-%d %H:00:00")
    end_time = datetime.datetime.now().strftime("%Y-%m-%d %H:00:00")

    slowquery_ojb = SlowQueryHistory.objects.filter(ts_min__range=(start_time, end_time)).values("hostname_max").annotate(
        counts=Sum('ts_cnt'),
        QueryTimeAvg=Sum('query_time_sum') / Sum('ts_cnt'),
    ).order_by('counts')  # 执行总次数倒序排列

    res = [SlowLog for SlowLog in slowquery_ojb]

    if res:
        try:
            strSlowquery = json.dumps(res)
            send_mail(strSlowquery)
        except json.decoder.JSONDecodeError as jde:
            logging.error("failed to parse response： %s", jde)
            pass
        except Exception as e:
            logging.error("failed: %s", e)

    return HttpResponse('success')


# 每周慢日志的报表，待加入计划任务
def alter_slow_report(request):

    current_date = time.strftime("%Y-%m-%d")
    import datetime
    start_time = datetime.datetime.strptime(current_date, '%Y-%m-%d') + datetime.timedelta(days=-7)
    end_time = time.strftime("%Y-%m-%d 23:59:59")

    # 查询数据库统计最近1个星期每天的慢日志
    slowquery_ojb = SlowQueryHistory.objects.filter(ts_min__range=(start_time, end_time)
                                                    ).extra(
        select={"byday": "DATE_FORMAT(ts_min, '%%Y-%%m-%%d')"}).values("byday").annotate(
        date_count=Sum('ts_cnt')).order_by('byday')  # 执行总次数倒序排列

    res = [SlowLog for SlowLog in slowquery_ojb]

    dates = [r['byday'] for r in res]
    counts = [r['date_count'] for r in res]

    # 字体的设置
    rcParams['axes.unicode_minus'] = False  # 用来正常显示负号
    matplotlib.rcParams['font.family'] = 'SimHei'
    mpl.rcParams['font.sans-serif'] = ['SimHei']  # 更新字体格式
    mpl.rcParams['font.size'] = 14

    plt.figure(figsize=(12, 4))   # 设置画布的尺寸

    plt.title('慢SQL数量趋势图', fontsize=20)   # 标题，并设定字号大小
    plt.plot(dates, np.asarray(counts), label='慢SQL数量')   # dates 为X轴的数据， np.asarray(counts) 为Y轴的数据

    plt.legend()  # 图例展示位置

    plt.xticks(rotation=-30, ha='left')
    plt.tick_params(axis='x', labelsize=8)
    # 显示图形
    now = float(time.time())
    pic_name = str(now) + ".jpg"
    plt.savefig(pic_name)
    plt.close()

    from datetime import datetime
    report = render_to_string("slowsql.html", context={
        "send_time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    })

    # 邮件服务器
    host = 'smtp.163.com'
    # 端口号
    port = 465
    # 授权码
    pwd = ''
    # 发送者
    sender = '13202095158@163.com'

    # 创建一个带附件的实例
    msg = MIMEMultipart('related')

    # 邮件的主题，也就是邮件的标题
    msg['subject'] = '[Report]: 慢SQL周报 '
    # 发件人邮箱账号
    msg['from'] = '13202095158@163.com'
    # 收件人邮箱账号
    receiver = ['13202095158@163.com', '1224056230@qq.com']
    msg['to'] = ",".join(receiver)

    # 邮件正文内容
    format = 'html'
    content = MIMEText(report, format, 'utf-8')
    msg.attach(content)

    # 构造附件, 传入图片
    with open(pic_name, "rb") as f:
        pic = MIMEImage(f.read())
        # 定义图片 ID，在 HTML 文本中引用
        pic.add_header('Content-ID', '<pic>')
        msg.attach(pic)

    try:
        server = smtplib.SMTP_SSL(host, port)
        server.login(sender, pwd)
        server.sendmail(sender, receiver, msg.as_string())
        message = 'Done.sent email success'
    except smtplib.SMTPException as e:
        # 后面要收集日志到文件中
        print(str(e))
        message = 'Error.sent email fail'

    os.remove(pic_name)
    return HttpResponse(message)


def send_mail(body, format='plain'):
    # 邮件服务器
    host = 'smtp.163.com'
    # 端口号
    port = 465
    # 授权码
    pwd = ''
    # 发送者
    sender = '13202095158@163.com'
    # 邮件的内容
    body = body
    msg = MIMEText(body, format, 'utf-8')
    # 邮件的主题，也就是邮件的标题
    msg['subject'] = '[report]: slow_query_log '
    # 发件人邮箱账号
    msg['from'] = '13202095158@163.com'
    # 收件人邮箱账号
    receiver = ['13202095158@163.com', '1224056230@qq.com']
    msg['to'] = ",".join(receiver)

    try:
        server = smtplib.SMTP_SSL(host, port)
        server.login(sender, pwd)
        server.sendmail(sender, receiver, msg.as_string())
        return 'Done.sent email success'
    except smtplib.SMTPException as e:
        return 'Error.sent email fail'


def alter_sample(request):

    send_mail("1111")

    return HttpResponse('success')



def alter_html_sample(request):

    report = render_to_string("slowsql.html", context={
        "send_time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    })


    send_mail(report, 'html')

    return HttpResponse('success')



# 在 HTML 文本中添加图片
def alter_html_with_image_sample(request):

    report = render_to_string("slowsql.html", context={
        "send_time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    })

    print(report)
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
        <h1>邮件：</h1>
        <p>2021-01-21 15:35:40</p>
        <p><img src="cid:pic"></p>
    </body>
    </html>
    
    """
    # 邮件服务器
    host = 'smtp.163.com'
    # 端口号
    port = 465
    # 授权码
    pwd = ''
    # 发送者
    sender = '13202095158@163.com'

    # 创建一个带附件的实例
    msg = MIMEMultipart('related')

    # 邮件的主题，也就是邮件的标题
    msg['subject'] = '[report]: slow_query_log '
    # 发件人邮箱账号
    msg['from'] = '13202095158@163.com'
    # 收件人邮箱账号
    receiver = ['13202095158@163.com', '1224056230@qq.com']
    msg['to'] = ",".join(receiver)

    # 邮件正文内容
    format = 'html'
    content = MIMEText(report, format, 'utf-8')
    msg.attach(content)

    # 构造附件1, 传入 ./slowquery/20210121.jpg 图片
    pic_name = "./slowquery/20210121.jpg"
    with open(pic_name, "rb") as f:
        pic = MIMEImage(f.read())
        # 定义图片 ID，在 HTML 文本中引用
        pic.add_header('Content-ID', '<pic>')
        msg.attach(pic)

    # 构造附件2, 传入 ./slowquery/2021012102.jpg 图片
    # pic_name = "./slowquery/2021012102.jpg"
    # with open(pic_name, "rb") as f:
    #     pic = MIMEImage(f.read())
    #     pic.add_header('Content-ID', '<pic>')
    #     msg.attach(pic)


    try:
        server = smtplib.SMTP_SSL(host, port)
        server.login(sender, pwd)
        server.sendmail(sender, receiver, msg.as_string())
        message = 'Done.sent email success'
    except smtplib.SMTPException as e:
        message = 'Error.sent email fail'

    return HttpResponse(message)



def matplotlib_sample(request):

    np.random.seed(2)
    y = np.random.random(10)
    print(y)
    z = np.random.random(10)
    print(z)
    x = range(len(y))

    plt.grid()  # 网格
    plt.plot(y, c='g', linewidth=1.5, label='plot 1')  # 折线图
    plt.plot(z, c='b', linewidth=1.5, label='plot 2')  # 折线图

    plt.xlabel('x')  # 设置x轴标签
    plt.ylabel('y')  # 设置y轴标签

    plt.xlim(-1, 10)  # 设置x轴的范围
    plt.ylim(0, 1)  # 设置y轴的范围

    plt.scatter(x, y, marker='o', c='r')  # 散点
    plt.scatter(x, z, marker='s', c='r')  # 散点
    plt.legend()  # 图例

    plt.title('matplotlab')  # 设置标题

    plt.show()

    return HttpResponse(plt.show())
