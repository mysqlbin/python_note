<template>
  <div class="about">
    <h1>简单的计算器</h1>
    <p>
      <!-- 3种不同的方式 -->
      <button @click="add()">+</button>
      <button @click="sub">-</button>
      <button @click="numbers--">--</button>
    </p>
    <p>
      {{numbers}}
    </p>
  </div>
</template>

<script>

/*

VUE是mvvm模式
MVVM是Model-View-ViewModel的简写。它本质上就是MVC 的改进版。MVVM 就是将其中的View 的状态和行为抽象化，让我们将视图 UI 和业务逻辑分开。

template 是 view
model 是 javascript代码
ViewModel 是 view 跟 model 之间的桥梁：
  databind：数据绑定
  dom listener：dom监听

Vue 还提供了 v-model 指令，它能轻松实现表单输入和应用状态之间的双向绑定。 

*/

// 导入一个default对象
export default {
  data(){
    return {
      // 定义numbers变量，默认值为0
      numbers: 0
    }
  },
  methods:{
    add(){
      // 对变量进行加法计算
      this.numbers++
    },
    sub(){
      // 对变量进行减法计算
      this.numbers--
    }
  }
}

</script> 

