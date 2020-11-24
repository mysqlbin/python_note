
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
	
	3. 在父组件中，调用子组件的方法
	
	4. loading
		https://element.eleme.io/#/zh-CN/component/loading
		
	5. 打开http://127.0.0.1:8080/mysql链接，表格就加载数据
	
	6. 计算属性
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

	
未完成：
	分页相关
	二次确认
	

自己完成的2个功能：
	1. 二次确认
	2. 页面一加载就把表格数据展示出来
	

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
	
	
	
