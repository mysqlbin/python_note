import Vue from 'vue'
import Vuex from 'vuex'
import {getCurrentUser} from '../api/user'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    username: {}  // 我们先定义一个状态(存入的是一个全局变量)，表示登录的用户。默认是一个空对象
  },
  mutations: {
    setUser (state, username) {
      state.username = username
    }
  },
  actions: {  
    // 方法名
    getCurrentUserF(context) {
      let {commit} = context
      console.log('content: ', context)
      console.log('context_typeof: ', typeof(context))  // context_typeof:  object
      console.log('commit_typeof: ', typeof(commit))    // commit_typeof:   function
      console.log('commit: ', {commit})
      
      return new Promise((resolve, reject) => {
        if(_.isEmpty(context.state.username)) {
          // getCurrentUser() 是一个API函数，这里then()方法的作用就是回调
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
  modules: {
  }
})
