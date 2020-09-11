from django.contrib import admin

# Register your models here.

from .models import Reporter, Message

admin.site.register(Reporter)
# admin.site.register(Message)

@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):

    # 按照更详细的时间分类
    date_hierarchy = 'create_time'

    # 设置在列表中显示的字段，id为django模型默认的主键
    list_display = ('id', 'username', 'create_time', 'email')

    # 设置通过点击某一字段可跳转至修改页面
    list_display_links = ('username',)

    # 显示在页面右侧的历史过滤内容
    list_filter = ('create_time', 'username')

    # 默认的, ManyToManyField 会在管理站点上显示一个（多选框）．但是，当选择多个时多选框非常难用. 添加一个 ManyToManyField 到该列表将使用一个漂亮的低调的JavaScript中的“过滤器”界面,允许搜索选项。选和不选选项框并排出现。
    # filter_horizontal = ('create_time',)


