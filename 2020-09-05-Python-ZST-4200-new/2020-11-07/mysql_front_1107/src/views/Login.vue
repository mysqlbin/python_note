<template>
  <div>
      <form action="">
            <h1>user name: {{'DR: ' + login.username.toUpperCase()}}</h1>
            <div class="form-item form-item2" >
                <input type="text" name="username" v-model="login.username">
            </div>
            <div class="form-item">
                <input type="password" name="password"  v-model="login.password">
            </div>
            <div class="form-item">
                <button type="button" @click="handleLogin">登录</button>
            </div>
        </form>
        <!-- <div id="main" style="height: 400px;"></div> -->
  </div>
</template>

<script>

  // import Axios from "axios"
  import {login} from '../api/auth'

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
    created(){
      console.log('created')
        
    },
    mounted(){
      console.log("mounted")
      // this.drawChart()
    },
    methods: {
      handleLogin(){
        console.log(this.login.username)
        // this.login.username = this.login.username.toUpperCase()

        // this.login 就是参数
        // Axios.post('/user/api/django_ldap_login/', this.login).then(resp => {
        
        // 1. 如果有多个axios请求，没有必要为每个请求都写 axios.post(), 因此可以独立出来 
        // 2. 同一个APP的每个axios请求的URL前缀都是一样，因此又可以独立出来  

        login(this.login).then(resp => {
          console.log(resp)
          let data = resp.data

          if (_.isInteger(data.code)){
              console.log('code is int')
          }else{
              console.log('code is not int')
          }

          if (data.code === 2000) {

                alert('登录成功')
                this.$store.commit('setUser', data.data)

                // 获取redirect参数, 传入 this.$router.push() 中
                this.$router.push(this.$route.query.redirect);

                const curr = localStorage.getItem('preRoute')

                console.log('preRoute: ', curr)

                if (curr == null) {
                  this.$router.push({ path: "/" });
                } else {
                  this.$router.push({ path: curr });
                }
              
            }else{
                alert('登录失败')
            }

        }).catch(err => {
          alert('无法连接服务器')
          console.error(err)
        })

        console.log('after post')

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
</style>