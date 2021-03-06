import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import echarts from "echarts"
import lodash from 'lodash'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI)


Vue.config.productionTip = false

Vue.prototype.$echarts = echarts

window._ = lodash

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
