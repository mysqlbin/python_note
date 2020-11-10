<template>
  <div>
      <form action="">
            
            <div class="form-item form-item2" >
                <input type="text" name="username" v-model="login.username">
            </div>
            <div class="form-item">
                <input type="password" name="password" >
            </div>
            <div class="form-item">
                <button type="button" @click="handleLogin">登录</button>
            </div>
        </form>
        <!-- <div id="main" style="height: 400px;"></div> -->
  </div>
</template>

<script>
  export default {
    name: 'Login',
    data(){
      return {
        login: {
          username: "",
          password: "",
        }
      }
    },
    methods: {
      handleLogin(){
        console.log(this.login.username)
      }  
    }
  }
</script>

<style scoped>
  .form-item {
    margin-bottom: 20px;  /* margin-bottom 就是元素的下边距，相当于把排在下面的元素往下方移动了20个像素，px是单位，表示像素点*/
  }
</style>