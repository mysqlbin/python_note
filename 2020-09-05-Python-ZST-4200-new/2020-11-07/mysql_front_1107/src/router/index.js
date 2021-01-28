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

// 类似于全局的权限控制，不管跳转到哪个页面，都会走这个判断逻辑
// 登录跳转，判断用户是否有登录
router.beforeEach(async(to, from, next) => {
  let username = await store.dispatch('getCurrentUser') 
  let hasLogin = !_.isEmpty(username)
	if (to.path !== '/login') {
		if (hasLogin) {
			next()
		}else{
      // 用户还没有登录，跳转到登录界面
      // 将目的路由地址存入login的query中; 当登录成功后，获取这个query(this.$route.query.redirect)，跳转到登录前的页面
			next({
        path:"/login",
        query: {redirect: to.fullPath}  
      })
    }
  // 访问登录页面
  }else{
    if(hasLogin) {
      next('/')
    }else{
      next()
    } 
  }
})

