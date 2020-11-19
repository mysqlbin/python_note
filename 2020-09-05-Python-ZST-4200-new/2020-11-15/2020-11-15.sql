
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



https://blog.csdn.net/longzhoufeng/article/details/106646698   vue实现登录后跳转到之前的页面
https://www.cnblogs.com/goloving/p/9147975.html     


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


