<template>
  <div>
    <p>
        <input type="text" v-model="newcontent"/>
        <button @click="add">添加</button>
    </p>
    <ul>
      <li v-for="(v, k) in todo_list" :key="k">

        <template v-if="v.isEdit" >
            <input type="text" v-model="v.content" />
        </template>

        <template v-else>
              {{ v.content }} 
        </template>


        <button @click="toUpdate(k)">编辑</button>
        <button @click="toDelete(k)">删除</button>
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
    return {  
      // 在组件的 data 选项中声明初始值
      todo_list: [],   
      newcontent: '',
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
      // 赋值给todo_list
      
      this.todo_list = resp.data.data
      console.log('resp: ', resp.data)

     })
  },
  methods:{
   toDelete(key){
     // console.log('delete ' + 'key:' + key + ', content: ' + this.todo_list[index].content)
     this.todo_list.splice(key, 1)
   },
   toUpdate(key){
     this.$set(this.todo_list[key], 'isEdit', true)
     console.log(this.todo_list[key])
    //  console.log(this.todo_list)
   },
   add(){
     console.log(this.newcontent)
     console.log(this.todo_list.length)
     this.todo_list.push({
       "content": this.newcontent,
       "id": this.todo_list.length
     })
   },
  }
}

</script> 

