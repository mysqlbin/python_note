import Vue from 'vue'
import Vuex from 'vuex'
import {getCurrentUser} from '../api/user'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {}
  },
  mutations: {
    setUser (state, user) {
      state.user = user
    }
  },
  actions: {  
    getCurrentUser(context) {
      let {commit} = context
      console.log('content: ',context)
      return new Promise((resolve, reject) => {
        if(_.isEmpty(context.state.user)) {
          getCurrentUser().then(resp => {
            let respData = resp.data
            if (respData.code === 2000) {
              console.log("login user1: ", respData.data)
              commit('setUser', respData.data)
              resolve("login user2:", respData.data)
            }else{
              resolve({})
            }
         }).catch(err => {
            resolve({})
          })
        }else{
          resolve(context.state.user) 
        }
      })
    }

  },
  modules: {
  }
})
