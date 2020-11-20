<template>
  <div>
    <p>
        <input type="text" v-model="newcontent" 
          @keyup.enter="add" 
            @blur="check" 
              @focus="print('我获得焦点了')" 
                @input="onInput"
                />

        <button @click="add">添加</button>
     </p>
    <!-- <p> {{todoArrayLength}} </p>
    
    <p> {{ fullName }} </p> -->
    <ul>
      <li v-for="(v, k) in todo_list" :key="k">
        <TodoItems :textcontent="v.content" @delItem="toDelete(k)" @updateItem="toUpdate(k)">
          slot1
          <template  v-slot:content>
              slot2-content
            </template> 
        </TodoItems> 
        
<!-- 
        <template v-if="v.isEdit" >
            <input type="text" v-model="v.content" />
        </template>

        <template v-else>
              {{ v.content }} 
        </template>

        <button @click="toUpdate(k)">编辑</button>
        <button @click="toDelete(k)">删除</button> -->

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

m：model 也就是数据层
v: view  相当于是HTML页面，用于展示数据
vm: viewmodel 相当于是中间层

data(){}:
  当一个 Vue 实例被创建时，它将 data 对象中的所有的 property(属性) 加入到 Vue 的响应式系统中。
  当这些 property(属性)  的值发生改变时，视图将会产生“响应”，即匹配更新为新的值。

*/
import TodoItems from '../components/TodoItem'
// 导入一个default对象
export default {
  // name这里不写也可以
  name: 'Axiosstudy',    
  // 添加components属性
  components: {TodoItems},

  // data() 函数
  data(){
    return {  
      // 在组件的 data 选项中声明初始值
      todo_list: [],   
      newcontent: '',
      firstName: 'a',
      lastName: 'b'
    }
  },
  // 计算属性
  computed: {
     todoArrayLength(){
       if (this.todo_list.length === 10){
         return 'None'
       }else{
         return this.todo_list.length
       }
     },
     fullName: {
        // getter，读取
        get: function () {
          return this.firstName + ' ' + this.lastName
        },

        // setter，修改计算属性的值, 参数newValue = this.fullName
        set: function(newValue) {

          this.firstName = newValue[0]
          this.lastName = newValue[2]
        }
     }
   },
  // created 函数
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
      this.todo_list = resp.data.data  // 赋值给todo_list
      console.log('resp: ', resp.data)

     })
  },
  // mounted 函数，做一些 hook 操作。
  mounted(){

    this.fullName = 'c b'

  },
  // methods 属性
  // 在methods内部访问data中的数据：this.属性名
  // 在 `methods` 对象中定义方法
  methods:{
   toDelete(key){
     // console.log('delete ' + 'key:' + key + ', content: ' + this.todo_list[index].content)
     this.todo_list.splice(key, 1)
   },
   toUpdate(key){
     // this.$set(object, propertyname(属性名), value) ； 正确写法：this.$set(this.data,”key”,value')
     this.$set(this.todo_list[key], 'isEdit', 'aaa')
     console.log(this.todo_list[key])
     console.log(this.todo_list[key].content)
    //  console.log(this.todo_list)
   },
   add(){

     if (this.newcontent == ""){
       console.log('输入内容不能为空')
       return
     }
     console.log(this.newcontent)
     console.log(this.todo_list.length)
     this.todo_list.push({
       "content": this.newcontent,
       "id": this.todo_list.length
     })
     
     // 清空 input框的值
     this.newcontent = ""

   },
   print(val){
     console.log(val)
   },
   check(){
      if (this.newcontent == ""){
       console.log('输入内容不能为空')
       return
     }
   },
   onInput(val){
     console.log(val)
     console.log(val.data)
   },
   
  }
}

</script> 

