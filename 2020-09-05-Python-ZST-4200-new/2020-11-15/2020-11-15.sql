
if to.path != ‘login’ 也就是访问除登录界面以外的界面
• if 用户这时候已经登录了
• 那么允许用户继续访问
• else 用户还没有登录
• 跳转到登录界面
• else
• if 用户已经登录
• 跳转到除登录界面以外的界面
• else
• 允许用户继续访问，也就是login页面

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
  

to {name: "About", meta: {…}, path: "/about", hash: "", query: {…}, …}
index.js:54 from {name: "Login", meta: {…}, path: "/login", hash: "", query: {…}, …}


https://router.vuejs.org/zh/guide/advanced/navigation-guards.html#%E5%85%A8%E5%B1%80%E5%89%8D%E7%BD%AE%E5%AE%88%E5%8D%AB


next('/') 和 next() 的区别
	next('/') 跳转到首页
	next()    跳转到to
	
to, from ,next这三个参数，也就是页面跳转时的一些信息，分别是
to   ：目的路由(最终要跳转到的地址)、即将要进入的目标 路由对象
from ：来源的路由(从哪个地址过来的)、当前导航正要离开的路由

next ：一个函数，调用next()就跳转到to; 
next('some_path') 半路拦截，跳转到其他的地方

-- 如何解决next无限循环


第二种方式
	https://blog.csdn.net/longzhoufeng/article/details/106646698   vue实现登录后跳转到之前的页面
	https://www.cnblogs.com/goloving/p/9147975.html     
	https://segmentfault.com/q/1010000009846553    
	http://www.mamicode.com/info-detail-1871916.html

第一种方式
	https://blog.csdn.net/longzhoufeng/article/details/106646698


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

新增问题
	this.$route  跟 this.$router 的区别 
	https://www.jb51.net/article/164718.htm
	
	this.$router.push(this.$route.query.redirect);
	
	this.$router是VueRouter的实例方法，当导航到不同url，可以使用this.$router.push方法，这个方法则会向history里面添加一条记录，当点击浏览器回退按钮或者this.$router.back()就会回退之前的url。
	
	const router = new VueRouter({
	  mode: 'history',
	  base: process.env.BASE_URL,
	  routes
	})
	
	this.$route相当于当前激活的路由对象，包含当前url解析得到的数据，可以从对象里获取一些数据，如name,path等。