import Vue from 'vue'
import Vuex from 'vuex'
import {getCurrentUser} from '../api/user'
import {login} from '../api/user'

Vue.use(Vuex)

export default new Vuex.Store({
  // 初始化状态
  state: {
    username: {}  // 我们先定义一个状态(存入的是一个全局变量)，表示登录的用户。默认是一个空对象
  },
  // 同步操作，可用于登录成功后读取用户信息写到缓存里
  mutations: {
    setUser (state, username) {
      state.username = username
    }
  },
  // 异步操作
  actions: {  

    // 方法名
    login(context, loginRequest){
      let {commit} = context
      console.log("loginRequest: ", loginRequest)
      console.log("loginRequest type: ", typeof(loginRequest))
      // 对象的解构
      const { username, password } = loginRequest
      return new Promise((resolve, reject) => {
        // 异步请求
        login(loginRequest).then(resp => {
          console.log('username:', username)
          commit('setUser', username)
          resolve("登录成功")
        }).catch(err => {
          reject(err)
        })
      })
    },
    // 获取用户名
    getCurrentUser(context) {
      let {commit} = context
      // console.log('content: ', context)
      // console.log('context_typeof: ', typeof(context))  // context_typeof:  object
      // console.log('commit_typeof: ', typeof(commit))    // commit_typeof:   function
      // console.log('commit: ', {commit})
      // console.log('context.state.username: ', context.state.username)
      return new Promise((resolve, reject) => {
        if(_.isEmpty(context.state.username)) {
          // getCurrentUser() 是一个API函数，这里then()方法的作用就是回调
          // 异步请求
          getCurrentUser().then(resp => {
            let respData = resp.data
            if (respData.code === 2000) {
              // commit：同步操作，数据提交至 mutations setUser()，用于存储用户的登录状态
              commit('setUser', respData.data)
              // 返回用户名
              resolve(respData.data)
            }else{
              // 返回1个空对象
              resolve({})
            }
         }).catch(err => {
           // 返回1个空对象
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
