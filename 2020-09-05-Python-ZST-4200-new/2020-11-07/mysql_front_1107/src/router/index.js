import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Zst from '../views/Zst.vue'
import Login from '../views/Login.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/zst',
    name: 'Zst',
    // component: Zst
    // component: function(){
    //   return import('../views/Zst.vue')
    // }
    component: () => import('../views/Zst.vue')
  },
  {
    path: '/login',
    name: 'Login',
    // component: Zst
    // component: function(){
    //   return import('../views/Zst.vue')
    // }
    component: () => import('../views/Login.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
