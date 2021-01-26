import Vue from 'vue'
import VueRouter from 'vue-router'
// import Home from '../views/Home.vue'
// import Zst from '../views/Zst.vue'
// import Login from '../views/Login.vue'
import store from '../store'

Vue.use(VueRouter)

export const menuRouts = [
  {   // 一个对象就是一个路由声明
    path: '/',   // path 路径
    name: 'Home',
    component: () => import('@/layout/index'),   // component 组件
    redirect: '/home',
    meta: { title: 'Dashboard' },
    children: [
      {
        path: 'home',
        name: 'Home',
        meta: { title: 'Home' },
        component: () => import('@/views/Home')
      },
      {
        path: 'about',
        name: 'About',
        meta: { title: 'About' },
        component: () => import('@/views/About')
      },

    ]
  },
  {
    path: '/schema_manage',
    meta: {title: '数据库管理'},
    component: () => import('@/layout/index'),
    children: [
        {
            path: 'mysql',
            name: 'MySQLManage',
            meta: { title: 'MySQL实例列表' },
            component: () => import('@/views/schema_manage/mysql')
        }
    ]
  },
  {
    path: '/slowsql',
    meta: { title: '慢SQL管理-从ES读取' },
    component: () => import('@/layout/index'),
    children: [
        {
            path: 'list',
            meta: { title: '列表' },
            component: () => import('@/views/slowsql/index')
        },
        {
          path: 'aggr_list',
          meta: { title: '聚合列表' },
          component: () => import('@/views/slowsql/aggr_list')
        },
        {
          path: 'slow_sample',
          meta: { title: '慢查询图表' },
          component: () => import('@/views/slowsql/slow_sample')
        },
        {
          path: 'sample',
          meta: { title: 'Highcharts图表示例' },
          component: () => import('@/views/slowsql/sample')
        },

    ]
  },
  {
    path: '/slowquery',
    meta: { title: '慢SQL管理-从MySQL读取' },
    component: () => import('@/layout/index'),
    children: [
        {
            path: 'list',
            meta: { title: '列表' },
            component: () => import('@/views/slowquery/index')
        },
        {
          path: 'aggr_list',
          meta: { title: '聚合列表' },
          component: () => import('@/views/slowquery/aggr_list')
        },
        {
          path: 'slow_sample',
          meta: { title: '慢查询图表' },
          component: () => import('@/views/slowquery/slow_sample')
        },
        
    ]
  },
]


const mainRouter = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login')
  }
]

const routes = [].concat(
    mainRouter,
    menuRouts,
    
)

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})


export default router

router.beforeEach(async(to, from, next) => {
  let username = await store.dispatch('getCurrentUserF') 
	// console.log('current username:', username)
	let hasLogin = !_.isEmpty(username)
	if (to.path !== '/login') {
		if (hasLogin) {
			next()
		}else{
			next({
        path:"/login",
        query: {redirect: to.fullPath}  //将目的路由地址存入login的query中; 当登录成功后，获取这个query(this.$route.query.redirect)，跳转到登录前的页面
      })
		}
	}else{
		if(hasLogin) {
			next('/')
		}else{
			next()
		} 
	}
})


/*
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
	  // 
	  // 让异步函数变成像同步函数那样使用
	  //   await的含义为等待。意思就是代码需要等待await后面的函数运行完并且有了返回结果之后，才继续执行下面的代码。
	  // https://www.cnblogs.com/robinunix/articles/10900474.html
    let resp = await getCurrentUser()
    console.log(resp)
    let data = resp.data
 
    if (data.code === 2000) {
      console.log(11)
    // 键值对：键为 setUser，值为 store.state.user
      console.log("user: ", data.data)
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
      console.log('to path1: ', to.path)
      // vue实现登录后跳转到之前的页面
      // localStorage.setItem("preRoute", to.path)
      // next('/login')  

      next({
        path:"/login",
        query: {redirect: to.fullPath}  //将目的路由地址存入login的query中; 当登录成功后，获取这个query(this.$route.query.redirect)，跳转到登录前的页面
      })
    }

  // 访问登录界面
  }else{
    // 如果已经登录过
    if(hasLogin) {
      next('/')  //跳转到首页
      // // 获取 query 
      // console.log(31)
      // console.log('to path2: ', to.path)
      // console.log('from.query.redirect: ', from.query.redirect)
      // // next('/')  //跳转到首页
      
      // 获取redirect参数
      // let redirect = from.query.redirect
      // if (to.path === redirect){
      //   console.log(32)
      //   next('/') 
      // }else{
      //   console.log(33)
      //   console.log('path:redirect: ', {path:redirect})
      //   next({path:redirect}) //跳转到目的路由
      // }
      

    // 未登录， 访问登录页面
    }else{
      console.log(41)
      console.log('to path2: ', to.path)
      next()
    } 
  }
  
})
*/


/*
router.beforeEach(async(to, from , next) => {
  console.log('to', to)
  console.log('from', from)
  console.log('next', next)
  // 获取登录的用户
  let user = store.state.user
  if (_.isEmpty(user)) {
	  // 当user为空的时候，尝试从服务端获取一遍
	  // 让异步函数变成像同步函数那样使用
	  //   await的含义为等待。意思就是代码需要等待await后面的函数运行完并且有了返回结果之后，才继续执行下面的代码。
	  // https://www.cnblogs.com/robinunix/articles/10900474.html
    let resp = await getCurrentUser()
    let data = resp.data
    if (data.code === 2000) {
      user = data.data
	  // 键值对：键为 setUser，值为 store.state.user
      store.commit('setUser', user)
    }
  }
  
  // 用户没有登录
  if (_.isEmpty(user)) {
    console.log('you have not login')
    // next('/login')
    // next('/login')
    // next({ name: 'login' })
    // 用户没有登录，跳转到登录页面
    if (to.path !== '/login') {
      next('/login')
    }

  }else{
    console.log('you have login', user)
    next()
  }

  
})
*/



