

相关参考

	https://blog.csdn.net/ifenggege/article/details/86103918   ES（四）ES使用（基本查询、聚合查询）
	https://www.cnblogs.com/xing901022/p/4947436.html  Elasticsearch聚合 之 Terms
	
	
	highcharts图表相关
		https://www.highcharts.com.cn/docs/install-from-npm
		https://blog.jianshukeji.com/highcharts/use-highcharts-with-vue.html

		https://www.highcharts.com.cn/docs/highcharts-vue   Highcharts Vue


		https://codesandbox.io/embed/vue-template-c91vy?fontsize=14    vue使用highcharts示例


		https://codesandbox.io/s/nw4qk1zj24?file=/src/App.vue 

		https://codesandbox.io/s/nw4qk1zj24?file=/src/main.js


		https://jshare.com.cn/highstock/hhhhio/13  上课用的图表示例

			https://www.highcharts.com.cn/docs/highstock
			
			https://www.highcharts.com.cn/demo/highstock/spline
		
		https://www.highcharts.com.cn/demo/highcharts/pie-basic 饼状图
		
		https://demo-live-data.highcharts.com/aapl-c.json


未完成：
	总结下es的查询 


现象和问题：
	在login页面是可以正常通过绑定id属性渲染highcharts图表，login界面没有走菜单路由，Vue生命周期函数执行了一次
	在项目的导航路由的界面通过绑定id属性不能渲染highcharts图表，同时发现了在通过导航路由到的界面，Vue生命周期函数执行了两次
		-- html id的属性值是唯一的，不能有两个或者多个，特效也不会生效。因为 vue页面渲染了2次，造成id重复了，导致绑定id属性不能渲染highcharts图表。
		
	查了资料，和看了项目中跟路由相关的代码，果然还是路由的问题，路由使用不当，导致Vue生命周期函数执行了两次，从而不能渲染通过绑定id属性渲染highcharts图表
		
	引用<router-view></router-view>标签重复了，
		\src\layout\components\NavBar\index.vue 
		\src\layout\index.vue
		
		这2个地方都引用了 <router-view></router-view>标签，把 \src\layout\components\NavBar\index.vue  中的<router-view></router-view>标签代码注释掉。
		
		
	应该是 router 相关？
		https://blog.csdn.net/vsherlockv/article/details/103243323  vue echarts 遇到的bug之一 无法渲染的问题
		https://segmentfault.com/q/1010000017140653  vue里为什么所有页面的created钩子都执行了两次？

		https://blog.csdn.net/m0_47333020/article/details/110007087  Vue的created里的方法执行了两次

		https://forum.vuejs.org/t/vue/79642/3   为什么Vue生命周期函数执行了两次


	
	基础不牢，地动山摇
	

代码解读：

	-- 通过 $emit 发射1个事件
	this.$emit("updateQueryParams");
	
	this.updateQueryParams = _.debounce(
      function (startMsFloat, endMsFloat) {
        console.log("update time range");
        let startTime = _.toInteger(startMsFloat) / 1000;
        let endTime = _.toInteger(endMsFloat) / 1000;
        this.queryParams.start = moment.unix(startTime).format();
        this.queryParams.end = moment.unix(endTime).format();
        console.log(this.queryParams);
        this.$emit("updateQueryParams");   -- 时间范围合并的时候，通过 $emit 发射1个事件
      }.bind(this),
      250
    );
	
	-- 通过 $on 接收1个事件
	this.$on(
      "updateQueryParams",  --这是1个事件名字
      function () {  --这是1个回调函数
        console.log("query params has changed");
        this.doSearch();  -- 时间范围变化的时候，触发搜索事件
      }.bind(this)
    );

  xAxis: {
	events: {
	  // 范围选择器改变的范围最终是改变坐标轴的范围，所以我们监听坐标的极值变更事件函数即可
	  afterSetExtremes: function (e) {
		// e.min 和 e.max 为坐标轴当前的范围
		console.log(e.min, e.max);
		that.updateQueryParams(e.min, e.max);
	  },
	},
  },

	doSearch() {
      getTop10(this.queryParams).then(resp=> {
        this.tableData = resp.data
      })
	}


	
	



Highcharts.chart('container', {
		chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false,
				type: 'pie'
		},
		title: {
				text: '2018年1月浏览器市场份额'
		},
		tooltip: {
				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		},
		plotOptions: {
				pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						dataLabels: {
								enabled: true,
								format: '<b>{point.name}</b>: {point.percentage:.1f} %',
								style: {
										color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
								}
						}
				}
		},
		series: [{
				name: 'Brands',
				colorByPoint: true,
				data: [{
						name: 'Chrome',
						y: 61.41,
						sliced: true,
						selected: true
				}, {
						name: 'Internet Explorer',
						y: 11.84
				}, {
						name: 'Firefox',
						y: 10.85
				}, {
						name: 'Edge',
						y: 4.67
				}, {
						name: 'Safari',
						y: 4.18
				}, {
						name: 'Sogou Explorer',
						y: 1.64
				}, {
						name: 'Opera',
						y: 1.6
				}, {
						name: 'QQ',
						y: 1.2
				}, {
						name: 'Other',
						y: 2.61
				}]
		}]
});





1. 逐渐地理解了分页部分的代码






npm 是 nodejs 包管理工具

yarn add highcharts 
yarn add highcharts-vue 

yarn add jquery


var chart = Highcharts.chart('container', {
		title: {
				text: '2010 ~ 2016 年太阳能行业就业人员发展情况'
		},
		subtitle: {
				text: '数据来源：thesolarfoundation.com'
		},
		yAxis: {
				title: {
						text: '就业人数'
				}
		},
		legend: {
				layout: 'vertical',
				align: 'right',
				verticalAlign: 'middle'
		},
		plotOptions: {
				series: {
						label: {
								connectorAllowed: false
						},
						pointStart: 2010
				}
		},
		series: [{
				name: '安装，实施人员',
				data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
		}, {
				name: '工人',
				data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
		}, {
				name: '销售',
				data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
		}, {
				name: '项目开发',
				data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
		}, {
				name: '其他',
				data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
		}],
		responsive: {
				rules: [{
						condition: {
								maxWidth: 500
						},
						chartOptions: {
								legend: {
										layout: 'horizontal',
										align: 'center',
										verticalAlign: 'bottom'
								}
						}
				}]
		}
});










ERROR:root:exception occur: Invalid page.
Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/rest_framework/pagination.py", line 206, in paginate_queryset
    self.page = paginator.page(page_number)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/paginator.py", line 73, in page
    number = self.validate_number(number)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/django/core/paginator.py", line 55, in validate_number
    raise EmptyPage(_('That page contains no results'))
django.core.paginator.EmptyPage: That page contains no results

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/rest_framework/views.py", line 506, in dispatch
    response = handler(request, *args, **kwargs)
  File "/home/vagrant/src/python_note/2020-09-05-Python-ZST-4200-new/zst_mysql_1110/slowsql/views.py", line 257, in list
    data = paginator.paginate_queryset(rs, request)
  File "/home/vagrant/.local/share/virtualenvs/zst_mysql_1110-XKCR2RrO/lib/python3.6/site-packages/rest_framework/pagination.py", line 211, in paginate_queryset
    raise NotFound(msg)
rest_framework.exceptions.NotFound: Invalid page.


Highcharts.chart('container', {
		chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false,
				type: 'pie'
		},
		title: {
				text: '2018年1月浏览器市场份额'
		},
		tooltip: {
				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		},
		plotOptions: {
				pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						dataLabels: {
								enabled: true,
								format: '<b>{point.name}</b>: {point.percentage:.1f} %',
								style: {
										color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
								}
						}
				}
		},
		series: [{
				name: 'Brands',
				colorByPoint: true,
				data: [{
						name: 'Chrome',
						y: 61.41,
						sliced: true,
						selected: true
				}, {
						name: 'Internet Explorer',
						y: 11.84
				}, {
						name: 'Firefox',
						y: 10.85
				}, {
						name: 'Edge',
						y: 4.67
				}, {
						name: 'Safari',
						y: 4.18
				}, {
						name: 'Sogou Explorer',
						y: 1.64
				}, {
						name: 'Opera',
						y: 1.6
				}, {
						name: 'QQ',
						y: 1.2
				}, {
						name: 'Other',
						y: 2.61
				}]
		}]
});

