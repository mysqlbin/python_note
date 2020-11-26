<template>
  <div class="login-container">

    <el-form label-width="80px" class="login-form"  :model="formLogin" :rules="loginRules">
      <el-form-item label="username：" prop="username">
        <el-input v-model="formLogin.username" placeholder="请输入用户名" name="username"></el-input>
      </el-form-item>
     
     <el-form-item label="password：" prop="password">
        <el-input v-model="formLogin.password" show-password placeholder="请输入密码" name="password" ></el-input>
      </el-form-item>
      
      <el-form-item>
        <el-button :loading="loading" type="primary" @click.native.prevent="handleLogin">登录</el-button>
      </el-form-item>
    </el-form>
    
  </div>
</template>

<script>

  // import Axios from "axios"
  import {login} from '../api/auth'

  export default {
    name: 'Login',
    data(){
      return {
        loading: false,
        formLogin: {
          username: "",
          password: "",
        },
        //验证规则 
        loginRules: { 
          username: [
            { required: true, message: '请输入用户名', trigger: 'blur'},
            { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
          ],
          password: [
            { required: true, message: '请输入密码', trigger: 'blur'},
            { min:6, max: 64, message: '长度在 6 到 64 个字符', trigger: 'blur'}
          ] 
        }

      }
    },
    created(){
      // console.log('created')
        
    },
    mounted(){
      // console.log("mounted")
      // this.drawChart()
    },
    methods: {
      handleLogin(){
        console.log("login_username: ", this.formLogin.username)
        // this.login.username = this.login.username.toUpperCase()

        // this.login 就是参数
        // Axios.post('/user/api/django_ldap_login/', this.login).then(resp => {
        
        // 1. 如果有多个axios请求，没有必要为每个请求都写 axios.post(), 因此可以独立出来 
        // 2. 同一个APP的每个axios请求的URL前缀都是一样，因此又可以独立出来  

        this.loading = true   // 表示在加载中
        login(this.formLogin).then(resp => {
          console.log(resp)
          let data = resp.data

          if (_.isInteger(data.code)){
              console.log('code is int')
          }else{
              console.log('code is not int')
          }

          if (data.code === 2000) {

                this.$message.info('登录成功')
                this.$store.commit('setUser', data.data)

                let redirect = this.$route.query.redirect;
                redirect = _.isString(redirect) ? redirect : undefined;
                redirect = redirect ? decodeURI(redirect) : "/";
                console.log("redirect: ", redirect)
                this.$router.push({
                  path: redirect,
                });

                // 获取redirect参数, 传入 this.$router.push() 中, 跳转到登录前的页面
                // this.$router.push(this.$route.query.redirect);

                // const curr = localStorage.getItem('preRoute')

                // console.log('preRoute: ', curr)

                // if (curr == null) {
                //   this.$router.push({ path: "/" });
                // } else {
                //   this.$router.push({ path: curr });
                // }
              
            }else{
                this.$message.error('用户名或者密码不正确')
            }

        }).catch(err => {
         
          this.$message.error('无法连接服务器')
          console.error(err)

        }).finally(() => {
          // 访问完成，把 loading 改为 false
          this.loading = false
        })

        // console.log('after post')

      },
            // drawChart() {
            //     // 基于准备好的dom，初始化echarts实例
            //     let myChart = this.$echarts.init(document.getElementById("main"));
            //     // 指定图表的配置项和数据
            //     let option = {
            //         title: {
            //         text: "ECharts 入门示例"
            //         },
            //         tooltip: {},
            //         legend: {
            //         data: ["销量"]
            //         },
            //         xAxis: {
            //         data: ["衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"]
            //         },
            //         yAxis: {},
            //         series: [
            //         {
            //             name: "销量",
            //             type: "bar",
            //             data: [5, 20, 36, 10, 10, 20]
            //         }
            //         ]
            //     };
            //     // 使用刚指定的配置项和数据显示图表。
            //     myChart.setOption(option);
            // }  
    }
  }
</script>

<style scoped>
  .form-item {
    margin-bottom: 20px;  /* margin-bottom 就是元素的下边距，相当于把排在下面的元素往下方移动了20个像素，px是单位，表示像素点*/
  }

  .login-form{
 
    width: 520px;
    max-width: 100%;  /*当移动端的宽度没有520px，那么就使用max-width: 100%; 占满整个屏幕的宽度*/
    margin: 0 auto;
    padding: 160px 35px 0;
 
  }

</style>