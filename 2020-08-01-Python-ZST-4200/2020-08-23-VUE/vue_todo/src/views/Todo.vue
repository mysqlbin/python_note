<template>
  <div>
    <ul>
      <li v-for="(v, k) in todo_list" :key="k">
        <input type="text"/>
        {{ k }} - {{ v.content }} 
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


<li>
  <input type="text"/>
   1-今天去超市 
</li>
  此时input 框输入： 22222

然后对点击删除 ‘1-今天去超市’ 这个 li 标签中的 button 删除按钮
触发内部的修改逻辑如下：
  其中， 只修改应该修改的部分，没有必要对 input 的内容进行修改，因为没有对 input 进行任何的绑定，
  "
  0 - 今天去银行 
  1 - 今天去超市 
  2 - 今天去上班 
  3 - 今天去吃饭 
  "
  把  "1 - 今天去超市" 改为 "1 - 今天去上班"
  把  "2 - 今天去上班" 改为 "2 - 今天去吃饭"

  最后把 "3 - 今天去吃饭" 删除掉。

*/

// 导入一个default对象
export default {
  data(){
    return {  // 返回值
      todo_list: [
        {
          content: '今天去银行'
        },
         {
          content: '今天去超市'
        },
        {
          content: '今天去上班'
        },
        {
          content: '今天去吃饭'
        },
      ]
    }
  },
  methods:{
    toDelete(index){
        console.log('delete' + index + '' + this.todo_list[index].content)
        this.todo_list.splice(index, 1)
    }
  }
}

</script> 

