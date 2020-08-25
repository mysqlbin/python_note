<template>
  <div class="about">
    <h1>简单的计算器</h1>
    <p>
      <button @click="add()">+</button>
      <button @click="sub">-</button>
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
  databind
  dom listener

*/

// 导入一个default对象
export default {
  data(){
    return {
      // 默认为0
      numbers: 0
    }
  },
  methods:{
    add(){
      this.numbers++
    },
    sub(){
      this.numbers--
    }
  }
}

</script> 

