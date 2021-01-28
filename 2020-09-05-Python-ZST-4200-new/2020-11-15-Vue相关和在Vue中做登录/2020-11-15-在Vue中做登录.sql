


1. 当用户访问未登录界面时跳回登录界面
2. 导航守卫
3. vue实现登录后跳转到之前的页面
4. Vuex 
5. 问题
6. mutations和actions	
7. vue中异步函数async和await的用法
8. js变量赋值给大括号
9. 变量声明
10. router.beforeEach


1. 当用户访问未登录界面时跳回登录界面
	逻辑
		if to.path != ‘login’ 也就是访问除登录界面以外的界面
			• if 用户这时候已经登录了
				• 那么允许用户继续访问, 跳转到登录前的页面
			• else 用户还没有登录
				• 跳转到登录界面
		else
			• if 用户已经登录
				• 跳转到除登录界面以外的界面
			• else
				• 允许用户继续访问，也就是login页面
	代码实现
	
	// 也就是访问除登录界面以外的界面
	if (to.path !== '/login') {
		// 已经登录
		if (hasLogin) {
		  console.log(11)
		  next()          // 跳转到to
		// 未登录
		}else{
		  console.log(21)
		  console.log('to path1: ', to.path)
		  next('/login')  // 跳转到登录页面
		}
		
	// 访问登录页面
	}else{
		// 已经登录
		if(hasLogin) {
		  console.log(31)
		
		  next('/')  // 跳转到首页
		  
		// 未登录
		}else{
		  console.log(41)
		  console.log('to path2: ', to.path)
		  // localStorage.setItem("preRoute", router.currentRoute.fullPath)
		  next()    //  跳转到to
		} 
	}
	  
	
	  
2. 导航守卫

	next('/') 和 next() 的区别
		next('/') 跳转到首页
		next()    跳转到to
		
	to, from ,next这三个参数，也就是页面跳转时的一些信息，分别是
	to   ：目的路由(最终要跳转到的地址)、即将要进入的目标 路由对象
	from ：来源的路由(从哪个地址过来的)、当前导航正要离开的路由

	next ：一个函数，调用next()就跳转到to; 
		next('some_path') 半路拦截，跳转到其他的地方

	https://router.vuejs.org/zh/guide/advanced/navigation-guards.html#%E5%85%A8%E5%B1%80%E5%89%8D%E7%BD%AE%E5%AE%88%E5%8D%AB



	next() 表示路由成功，直接进入to路由，不会再次调用router.beforeEach()
	next('login') 表示路由拦截成功，重定向至login，会再次调用router.beforeEach()
	也就是说beforeEach()必须调用next(),否则就会出现无限循环，
	next() 和 next('xxx') 是不一样的，区别就是前者不会再次调用router.beforeEach()，后者会！！！


	to.path
	to.fullPath

	https://segmentfault.com/a/1190000011042794  关于vue-router的beforeEach无限循环的问题
	https://www.cnblogs.com/sinosaurus/p/9016163.html   vue-router beforeEach死循环
	
	-- 如何解决next无限循环

3. vue实现登录后跳转到之前的页面
	第二种方式
		https://blog.csdn.net/longzhoufeng/article/details/106646698   vue实现登录后跳转到之前的页面
		https://www.cnblogs.com/goloving/p/9147975.html     
		https://segmentfault.com/q/1010000009846553    
		http://www.mamicode.com/info-detail-1871916.html

	第一种方式
		https://blog.csdn.net/longzhoufeng/article/details/106646698

4. Vuex 
	Vuex 是一个专为Vue.js 应用程序开发的状态管理模式。
		它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。
	状态是什么， 简单地说，就是变量的取值
	我们把用户是否登录的状态放在vuex中，那么之前关于如何获取用户是否登录这个问题是否就解决了

	https://vuex.vuejs.org/zh/guide/
	


5. 问题
	1. this.$route  跟 this.$router 的区别 
		https://www.jb51.net/article/164718.htm
		
		this.$router.push(this.$route.query.redirect);
		
		this.$router是VueRouter的实例方法，当导航到不同url，可以使用this.$router.push方法，这个方法则会向history里面添加一条记录，当点击浏览器回退按钮或者this.$router.back()就会回退之前的url。
		
		const router = new VueRouter({
		  mode: 'history',
		  base: process.env.BASE_URL,
		  routes
		})
		
		this.$route相当于当前激活的路由对象，包含当前url解析得到的数据，可以从对象里获取一些数据，如 name,path 等。

			{
				path: 'Home',
				name: 'Home',
				meta: { title: 'Home' },
				component: Home
			},

			this_route:  
				{name: "MySQLManage", meta: {…}, path: "/mysql", hash: "", query: {…}, …}
				fullPath: "/mysql?page_num=1&page_size=5"
				hash: ""
				matched: (2) [{…}, {…}]
				meta: {__ob__: Observer}
				name: "MySQLManage"
				params: {}
				path: "/mysql"
				query: {page_num: "1", page_size: "5"}
				__proto__: Object
						  
	2.  new Promise((resolve, reject)
	
		https://blog.csdn.net/hyupeng1006/article/details/80351174  new Promise()讲解
	
		
	
	3. 
		vue-router.esm.js:2008 Uncaught (in promise) NavigationDuplicated: Avoided redundant navigation to current location: "/login".
			at createRouterError (http://localhost:8080/js/chunk-vendors.js:122269:15)
			at createNavigationDuplicatedError (http://localhost:8080/js/chunk-vendors.js:122239:15)
			at HTML5History.confirmTransition (http://localhost:8080/js/chunk-vendors.js:122532:18)
			at HTML5History.transitionTo (http://localhost:8080/js/chunk-vendors.js:122464:8)
			at HTML5History.push (http://localhost:8080/js/chunk-vendors.js:122805:10)
			at http://localhost:8080/js/chunk-vendors.js:123224:22
			at new Promise (<anonymous>)
			at VueRouter.push (http://localhost:8080/js/chunk-vendors.js:123223:12)
			at http://localhost:8080/js/app.js:1155:25
			-- NavigationDuplicated：避免冗余导航到当前位置：“ / login”


		vue-router.esm.js:2008 Uncaught (in promise) Error: Redirected when going from "/login?redirect=%2Fabout" to "/login" via a navigation guard.
			at createRouterError (vue-router.esm.js:2008)
			at createNavigationRedirectedError (vue-router.esm.js:1967)
			at vue-router.esm.js:2314
			at _callee$ (index.js:117)
			at tryCatch (runtime.js:63)
			at Generator.invoke [as _invoke] (runtime.js:293)
			at Generator.next (runtime.js:118)
			at asyncGeneratorStep (asyncToGenerator.js:3)
			at _next (asyncToGenerator.js:25)
			at asyncToGenerator.js:32


	4. this.$store.commit 和 this.$store.dispatch

		https://blog.csdn.net/AiHuanhuan110/article/details/89160241  vuex中store存储store.commit和store.dispatch的区别及用法
		
		https://blog.csdn.net/sunhuaqiang1/article/details/85211227   Vue进阶（二十四）：vue store存储commit 和dispatch
		
		代码示例：

			this.$store.commit('loginStatus', 1);

			this.$store.dispatch('isLogin', true);
	
		主要区别：

			dispatch：
				含有异步操作，数据提交至 actions ，可用于向后台提交数据
				写法示例： this.$store.dispatch('actions方法名',值)

			commit：
				同步操作，数据提交至 mutations ，可用于登录成功后读取用户信息写到缓存里
				写法示例： this.$store.commit('mutations方法名',值)
	
6. mutations和actions

	https://blog.csdn.net/joyvonlee/article/details/96916489  vuex的mutations用法
	https://vuex.vuejs.org/zh/guide/mutations.html   
	
	mutations 中不可以做异步操作, 在 Vuex 中，mutation 都是同步事务：
	actions   中可以做异步操作
	mutations 和 actions 都是 vuex 中的核心概念。	
	
		
	store/index.js
		export default new Vuex.Store({
		  state: {
			username: {}
		  },
		  mutations: {
			setUser (state, username) {    
			  state.username = username  // state.username：将state传进来了， 
			} 
		  },
			
	login.vue
		this.$store.commit('setUser', data.data)   
		// 触发mutations方法，同步操作，数据提交至mutations，其中 'setUser' 对应 setUser (state, username) 中的 setUser()方法
		
		你可以向 store.commit 传入额外的参数，即 mutation 的 载荷（payload）：
		data.data 就是额外的参数，对应 setUser (state, username) 中的 username 
		
		
		
	旧的代码
		router.beforeEach(async(to, from , next) => {
		  console.log('to   ：', to)
		  console.log('from ：', from)
		  console.log('next ：', next)
		  // 获取登录的用户并判断是否为空
		  let hasLogin = !_.isEmpty(store.state.user)
		  console.log("hasLogin: ", hasLogin)
		  // 当user为空的时候，尝试从服务端获取一遍
		  if (!hasLogin) {
			console.log("01")
			let resp = await getCurrentUser() // 同步操作
			console.log(resp)
			let data = resp.data
		 
			if (data.code === 2000) {
			  console.log(11)
			  console.log("user: ", data.data
			  )
			  
			// store.commit：同步操作，数据提交至 mutations ，可用于登录成功后读取用户信息写到缓存里
			// 键值对：键为 setUser，值为 store.state.user
			  store.commit('setUser', data.data)
			  hasLogin = true
			}else{
			  console.log("status: ", data.code)
			}

		  }
		  
		  // 访问除登录界面以外的界面
		  if (to.path !== '/login') {
			// 访问除登录界面以外的界面，但是已经登录
			if (hasLogin) {
			  // 做这个打印，是为了看代码执行到哪一步
			  console.log(11)
			  next()
			// 访问除登录界面以外的界面, 跳转到登录页面
			}else{
			  console.log(21)
			  next({
				path:"/login",
				query: {redirect: to.fullPath}  //将目的路由地址存入login的query中; 当登录成功后，获取这个query(this.$route.query.redirect)，跳转到登录前的页面
			  })
			}

		  // 访问登录界面
		  }else{
			// 如果已经登录过
			if(hasLogin) {
			  console.log(31)
			  next('/')  //跳转到首页
			  
			// 未登录， 访问登录页面
			}else{
			  console.log(41)
			  next()
			} 
		  }
		  
		})



	// 新的代码
	// 尝试读懂下面的代码，然后理解Promise
	  // store/index.js
	  actions: {  
		// 方法名
		// 这里的参数 context 是什么，感觉是回调函数，是的，从 actions 的回调函数来的。
		getCurrentUserF(context) {
		  let {commit} = context
		  console.log('content: ', context)
		  console.log('context_typeof: ', typeof(context))  // context_typeof:  object
		  console.log('commit_typeof: ', typeof(commit))    // commit_typeof:   function
		  console.log('commit: ', {commit})
		  / 返回一个 promise 对象，此时是异步请求
		  return new Promise((resolve, reject) => {
			if(_.isEmpty(context.state.username)) {
			  // getCurrentUser() 是一个API函数，发送一个API请求获取当前登录用户，这里then()方法的作用就是回调
			  getCurrentUser().then(resp => {
				let respData = resp.data
				if (respData.code === 2000) {
				  // commit：同步操作，数据提交至 mutations 
				  commit('setUser', respData.data)
				  // 返回用户名
				  resolve(respData.data)
				}else{
				  resolve({})
				}
			 }).catch(err => {
				resolve({})
			  })
			}else{
			  // 返回用户名
			  resolve(context.state.username) 
			}
		  })
		}

	  },	
	  
		// router/index.js 这里代码逻辑简化了很多
		router.beforeEach(async(to, from, next) => {
			// await 'getCurrentUserF' ： 同步操作 getCurrentUserF() 方法，getCurrentUserF() 方法中调用了一个 getCurrentUser() 是API函数获取用户名
			// dispatch： 含有异步操作，数据提交至 actions ，可用于向后台提交数据
			// 获取到用户名，通过 store.dispatch 提交给 actions
			let user = await store.dispatch('getCurrentUserF')
			console.log('current user:', user)
			let hasLogin = !_.isEmpty(user)
			if (to.path !== '/login') {
				if (hasLogin) {
					next()
				}else{
					next('/login')
				}
			}else{
				if(hasLogin) {
					next('/')
				}else{
					next()
				} 
			}
		})
		
	------------------------------------------------------------------------------------------


	https://www.cnblogs.com/xianrongbin/p/2781659.html  Vuex- Action的 { commit }


	1. 这里的 context 是什么，感觉是回调函数
		是的，从 actions 的回调函数来的。
		getCurrentUser(context) {
		console.log('context_typeof: ', typeof(context))  // context_typeof:  object
		
	2. let {commit} = context
		-- 将 对象 赋值给变量
		console.log("context: ", context)
		
		content: {getters: {…}, state: {…}, rootGetters: {…}, dispatch: ƒ, commit: ƒ, …}
			commit: ƒ boundCommit(type, payload, options)
			dispatch: ƒ boundDispatch(type, payload)
			getters: {}
			rootGetters: {}
			rootState: {__ob__: Observer}
			state: {__ob__: Observer}
			__proto__: Object

		console.log('commit: ',commit)
			commit:  ƒ boundCommit (type, payload, options) {
				return commit.call(store, type, payload, options)
			}
	  
	  
	  
		---------------------------------------------------------------------------
	
		let {commit} = context
	
	 	console.log('context_typeof: ', typeof(context))  // context_typeof:  object
		console.log('commit_typeof: ', typeof(commit))    // commit_typeof:   function
	 
	 
	3. resolve(respData.data)、resolve({})、resolve(context.state.user) 
		-- await 后面放置的就是返回 promise 对象的一个表达式
		-- 参考 《7. vue中异步函数async和await的用法》


		
	
7. vue中异步函数async和await的用法
	
	https://www.cnblogs.com/zhoujuan/p/11692818.html vue中异步函数async和await的用法
	
	现在再写一个 async 函数，从而可以使用 await 关键字， await 后面放置的就是返回 promise 对象的一个表达式，所以它后面可以写上 doubleAfter2seconds 函数的调用	
	
	async function testResult() {
		let result = await doubleAfter2seconds(30);
		console.log(result);
	}
	
	function doubleAfter2seconds(num) {
		return new Promise((resolve, reject) => {
			setTimeout(() => {
				resolve(2 * num)
			}, 2000);
		} )
	}
	
8. js变量赋值给大括号

	https://zhidao.baidu.com/question/1900506892331202140.html


	// 对象的解析

	let obj = {
		a: '1',
		b: '2',
		c: '3'
	}

	// var a, b, c;
	// a = obj.a;
	// b = obj.b;
	// c = obj.c;
	// console.log(a, b, c)
	
	跟上面的是一样的
	let {a, b, c} = obj;
	console.log(a, b, c)
	
	// let { a: a1, b: b1, c: c1 } = obj;
	// console.log(a1, b1, c1)

	
	var data = {};
	data.name = "hello";
	 
	let {name} = data;
	console.log(name); // hello
	
	
9. 变量声明
	函数内使用 var 声明的变量只能在函数内容访问，如果不使用，var 则是全局变量。
	使用 let 关键字来实现块级作用域
	const 用于声明一个或多个常量，不能通过再赋值修改，也不能再次声明


10. router.beforeEach
	https://blog.csdn.net/qq_26249609/article/details/94434711   vue router.beforeEach()，详解


