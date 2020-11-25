
https://element.eleme.cn/#/zh-CN



yarn add element-ui

yarn add sass-loader  



These dependencies were not found:

* element-ui in ./src/main.js
* element-ui/lib/theme-chalk/index.css in ./src/main.js

To install them, you can run: npm install --save element-ui element-ui/lib/theme-chalk/index.css




Cannot find module 'sass'

yarn add sass-loader  


拉取某个分支的代码
	git clone -b  11_21 https://github.com/textworld/mysql_front.git




https://blog.csdn.net/qq_37746973/article/details/78402812  在elementUI中使用 el-autocomplete 实现远程搜索的下拉框
https://element.eleme.cn/#/zh-CN
https://element.eleme.io/#/zh-CN/component/input    
	autocomplete 是一个可带输入建议的输入框组件，fetch-suggestions 是一个返回输入建议的方法属性，如 querySearch(queryString, cb)，在
	该方法中你可以在你的输入建议数据准备好时通过 cb(data) 返回到 autocomplete 组件中。

http://127.0.0.1:8001/api/meta_manage/mysql_schema/





我的问题
	1. action的作用
		@action(detail=True, methods=['get'])
		def get_schema_processlist(self, request, pk=None, *args, **kwargs):
		http://127.0.0.1:8001/api/meta_manage/mysql_schema/1/get_schema_processlist/
		-- detail=True 对应 /1/get_schema_processlist/
		
		
		@action(detail=False, methods=['get'])
		-- 获取所有的
		
		
		export function getProcessList(schemaId) {
			return request({
				url: `/v1/schema_info/mysql_schema/${schemaId}/get_process_list/`,
				method: 'get'
			})
		}

	2. dialog组件的使用
		用于弹窗
		需要设置visible属性，它接收Boolean，当为true时显示 Dialog。
			:visible.sync="dialogVisible"
			https://element.eleme.cn/#/zh-CN/component/dialog
		
		
	3. 在父组件中，调用子组件的方法
	
	4. loading
		https://element.eleme.io/#/zh-CN/component/loading
		
	5. 打开http://127.0.0.1:8080/mysql链接，表格就加载数据
		created() {
			this.doSearch()   // 调用加载数据的方法
		}
		
	6. 计算属性 computed
		把函数当成一个变量来使用，方便传值
		计算属性就是当其依赖属性的值发生变化时，这个属性的值会自动更新，与之相关的DOM部分也会同步自动更新。
	
	7. 访问路由不生效
		http://127.0.0.1:8080/mysql
		
		 {
			path: '/schema_manage',
			meta: {title: '数据库管理'},
			component: () => import('@/layout/index'),
			children: [
				{
					path: 'mysql',
					name: 'MySQLManage',
					meta: { title: 'mysql实例' },
					component: () => import('../views/schema_manage/mysql.vue')
				}
			]
		  }
  
	
	8. :index 和 :to 的含义
	
		<el-menu-item v-for="(child, cKey) in submenu.children" :key="cKey" :index="resolvePath2(submenu.path, '/', child.path)">
			{{resolvePath2(submenu.path, '/', child.path)}}
			<!-- {{child.path}} -->
			<router-link :to="child.path">{{routeName(child)}}</router-link>
		</el-menu-item>
		
		:index 和 :to 的含义
		
		:to
			https://www.cnblogs.com/superlizhao/p/8527317.html Vue-详解设置路由导航的两种方法： <router-link :to="..."> 和router.push(...)

			router-link :to
				表示目标路由的链接。当被点击后，内部会立刻把to的值传到router.push()，所以这个值可以是一个字符串或者是描述目标位置的对象。
				-- 类似于 router.beforeEach((to, from, next) => {}) 中的 to，要跳转到哪里。
		:index 
			https://segmentfault.com/q/1010000018863714 ElementUI导航条用index属性做路由时如何跳转到新页面
			
			-- 听一下老师上课讲的
			-- 不需要加也能跳转.
			
	9. :key="cKey" 加 : 号的含义和作用
		-- 遍历中用到，表示下标 key  的值
		
		https://www.cnblogs.com/liuqiyun/p/10876918.html   为什么vue组件的属性，有的需要加冒号“:”，有的不用?

		https://juejin.cn/post/6844904096365805575  VUE(五)-template语法
		
		
		v-for="(value, key) in 对象或数字" :key="每个元素不会重合的值。"
		

	
		<li v-for="(v, k) in todo_list" :key="k">
			<TodoItems :textcontent="v.content" @delItem="toDelete(k)" @updateItem="toUpdate(k)">
			  slot1
			  <template  v-slot:content>
				  slot2-content
				</template> 
			</TodoItems> 
			
		</li>	


		<el-menu-item-group>
			<el-menu-item v-for="(child, cKey) in submenu.children" :key="cKey" :index="resolvePath2(submenu.path, '/', child.path)">
				{{resolvePath2(submenu.path, '/', child.path)}}
				<!-- {{child.path}} -->
				<router-link :to="child.path">{{routeName(child)}}</router-link>
			</el-menu-item>
		</el-menu-item-group>


	-- Vue 基础知识需要提升，目前是在项目中学习
	
	
	10. loading 
		
		https://element.eleme.io/#/zh-CN/component/loading
		
		正在访问：loading = true 表示正在加载中...
		加载完成: loadin = false 表示关闭加载
		-- 网络请求慢，或者数据请求慢，页面提示"loading"，这时就起到作用了。
		
		:loading="scope.row.loading"	
				
	11. @click.native
	
		<el-dropdown-item @click.native="logout">退出</el-dropdown-item>
		el-dropdown-item 并不是 vue原生的元素，所以要加  .native 属性
		
		-----------------------
		
		<el-button :loading="loading" type="primary" @click.native.prevent="handleLogin">登录</el-button>
		-- prevent：阻止
		-- @click.native.prevent="handleLogin" 在form表单中，点击一个button按钮，触发 handleLogin函数，而不是使用form表单直接提交。
	
	
	12. to.path 和 to.fullPath
		
		http://127.0.0.1:8080/mysql?page_num=1&page_size=5
		
		console.log("path: ", to.path)
			path: /mysql
		
		console.log("fullPath: ", to.fullPath)
			fullPath: /mysql?page_num=1&page_size=5
		
		
	13.

		let redirect = this.$route.query.redirect;
		redirect = _.isString(redirect) ? redirect : undefined;
		redirect = redirect ? decodeURI(redirect) : "/";   -- 如果 redirect 为 undefined，就取 "/" ？
		this.$router.push({
		  path: redirect,
		});

		 
	-- 代码出问题了，一步步断点调试


	
	14. watch
		侦听事件
		https://cn.vuejs.org/v2/guide/computed.html#%E4%BE%A6%E5%90%AC%E5%99%A8  
		
		
		 // 不加这个，点击上一页、下一页不生效
		watch: {
			$route(to, from) {
				this.updateByQuery(to)
			}
		},
		
		侦听路由的变化

		watch: {
            dialogVisible(){
                console.log('dialogVisible', this.dialogVisible)
            }
        },
	
	15. dialogVisible
	
		需要设置visible属性，它接收Boolean，当为true时显示 Dialog。
			:visible.sync="dialogVisible"
		
		https://www.h5w3.com/16478.html  elementui代码visible.sync这是什么意思？
		 
		
		初始情况下通过该值控制 dialog显示。
		dialog关闭的时候，element自动设置该值为false
		-- 理解了。通过理论+实践理解的。
		
		
import path from 'path'
console.log("path: ", path)
path:  {resolve: ƒ, normalize: ƒ, isAbsolute: ƒ, join: ƒ, relative: ƒ, …}
			basename: ƒ (path, ext)delimiter: ":"dirname: ƒ (path)extname: ƒ (path)isAbsolute: ƒ (path)join: ƒ ()normalize: ƒ (path)relative: ƒ (from, to)resolve: ƒ ()sep: "/"__proto__: Object



path.resolve
	path.resolve(‘/目录1’, ‘/目录2’, ‘目录3’) 返回 “/目录2/目录3
	涉及到 vue router 的生成方式
	{
		path: '/dashboard',
		meta: { title: 'Dashboard' },
		component: () => import('@/layout/index'),
		redirect: '/home',
		children: [
			{
			path: '/home',
			name: 'Home',
			meta: { title: 'TodoList' },
			component: () => import('../views/Home')
			} 
		] 
	}
	如何访问  component: () => import('../views/Home') ？
	
	明白了原理之后，我们就知道了， 直接访问 /home 就行
	
	因为 访问 /home ，会有路径拼接， path.resolve('/dashboard', '/home') 会返回 /home
	
	
	代码示例：:index="resolvePath(submenu.path, child.path)"
		
		
		submenu.path 对应   path: '/dashboard'
		child.path   对应   path: '/home'
		
		resolvePath(submenu.path, child.path) 对应 resolvePath('/dashboard', '/home')
	

分页：

	SELECT `mysql_schema`.`gmt_update`, `mysql_schema`.`gmt_create`, `mysql_schema`.`id`, `mysql_schema`.`host_ip`, `mysql_schema`.`port`, `mysql_schema`.`schema`, `mysql_schema`.`role`, `mysql_schema`.`status`, `mysql_schema`.`phy_host_id` 
	FROM `mysql_schema` LIMIT 2 OFFSET 2
	
	OFFSET 2：第3条记录开始
	LIMIT 2: 取2条
	
	
	:current-page="searchBar.page_num"    当前第几页
	:page-sizes="[20, 100, 200, 500]"	  
	:page-size="searchBar.page_size"      每页多少行记录
	layout="total, sizes, prev, pager, next, jumper"
	:total="dataTotal">					  总共有多少行记录

		
	searchBar: {
		schema: "",
		status: "",
		page_size: 100,
		page_num: 1
	},
	
	class CustomPagination(PageNumberPagination):

		# 每页显示记录数，前端没有传入page_num，则默认显示此参数
		page_size = 2

		# 前端传入每页显示的数量
		page_size_query_param = 'page_size'

		# 前端传入第几页
		page_query_param = 'page_num'

		# #后端控制每页显示最大记录数
		max_page_size = 500

	https://blog.csdn.net/bubblelone/article/details/106630535    PageNumberPagination分页器使用

	https://www.cnblogs.com/863652104kai/p/11523358.html#%E4%BE%A6%E5%90%AC%E5%99%A8   drf - 基础分页组件 PageNumberPagination
	



	
	
https://www.cnblogs.com/hahahakc/p/12790463.html  使用Vuex实现登陆成功后展示登录用户的信息


	自己完成的2个功能：
	1. 二次确认
	2. 页面一加载就把表格数据展示出来
	