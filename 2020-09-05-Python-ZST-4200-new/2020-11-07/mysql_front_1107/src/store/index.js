import Vue from 'vue'
import Vuex from 'vuex'
import {getCurrentUser} from '../api/user'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    username: {}
  },
  mutations: {
    setUser (state, username) {
      state.username = username
    }
  },
  actions: {  
    getCurrentUser(context) {
      let {commit} = context
      console.log('content: ',context)
      return new Promise((resolve, reject) => {
        if(_.isEmpty(context.state.username)) {
          getCurrentUser().then(resp => {
            let respData = resp.data
            if (respData.code === 2000) {
              // console.log("login user1: ", respData.data)
              commit('setUser', respData.data)
              resolve(respData.data)
            }else{
              resolve({})
            }
         }).catch(err => {
            resolve({})
          })
        }else{
          resolve(context.state.username) 
        }
      })
    }

  },
  modules: {
  }
})
