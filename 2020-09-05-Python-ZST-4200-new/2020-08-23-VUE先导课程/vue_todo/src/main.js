import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'

// Vue.prototype.$axios = axios  // 原型链的方式引入

// 创建一个axios实例
const instance = axios.create({
  // baseURL: 'http://localhost:8089',
  timeout: 1000,
});

// 响应拦截器
// instance.interceptors.response.use((resp) => {

//   // console.log('debug')

//   if (resp.data.status === 0){
    
    
//     console.log('status: 0')
    
//   }

// },  (error) => {
  
// });


Vue.prototype.$axios = instance  // 原型链的方式引入


Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
