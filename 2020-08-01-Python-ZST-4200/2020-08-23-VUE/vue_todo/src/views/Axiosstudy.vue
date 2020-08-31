<template>
  <div>
    <ul>
      <li v-for="(v, k) in todo_list" :key="k">
        <input type="text"/>
        {{ v.content }} 
        <button @click="toDelete(k)">delete</button>
      </li>
      
    </ul>
  </div>
</template>

<script>

/*

VUE是mvvm模式
MVVM是Model-View-ViewModel的简写。它本质上就是MVC 的改进版。MVVM 就是将其中的View 的状态和行为抽象化，让我们将视图 UI 和业务逻辑分开。

template 是 view
model 是 javascript代码
ViewModel 是 view 跟 model 之间的桥梁：
  databind
  dom listener

*/

// 导入一个default对象
export default {
 
  name: 'Axiosstudy',    // name这里不写也可以

  data(){
    return {  // 返回值
      todo_list: []
    }
  },
  created() {
    //  this.$axios.get('https://5f4ca835ea007b0016b1e3f5.mockapi.io/article')
    //  .then(function(resp) {
    //    console.log('resp: ', resp)
    //  })

    //  this.$axios.get('https://5f4ca835ea007b0016b1e3f5.mockapi.io/article')
    //  .then(resp => {
    //    console.log('resp: ', resp)
    //  })

    //  this.$axios.get('https://www.baidu.com/')
    //  .then(function(resp) {
    //    console.log('resp: ', resp)
    //  })

     this.$axios.get('/api/todo/').then(resp => {

      this.todo_list = resp.data
      console.log('resp: ', resp.data)

     })
  },
  methods:{
   
  }
}

</script> 

