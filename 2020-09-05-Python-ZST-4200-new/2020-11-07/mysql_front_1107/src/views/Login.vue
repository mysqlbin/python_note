<template>
  <div>
      <form action="">
            <h1>user name: {{'DR: ' + login.username.toUpperCase()}}</h1>
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
        <div id="main" style="height: 400px;"></div>
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
    created(){
      console.log('created')
        
    },
    mounted(){
      console.log("mounted")
      this.drawChart()
    },
    methods: {
      handleLogin(){
        console.log(this.login.username)
        // this.login.username = this.login.username.toUpperCase()
      },
            drawChart() {
                // 基于准备好的dom，初始化echarts实例
                let myChart = this.$echarts.init(document.getElementById("main"));
                // 指定图表的配置项和数据
                let option = {
                    title: {
                    text: "ECharts 入门示例"
                    },
                    tooltip: {},
                    legend: {
                    data: ["销量"]
                    },
                    xAxis: {
                    data: ["衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"]
                    },
                    yAxis: {},
                    series: [
                    {
                        name: "销量",
                        type: "bar",
                        data: [5, 20, 36, 10, 10, 20]
                    }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }  
    }
  }
</script>

<style scoped>
  .form-item {
    margin-bottom: 20px;  /* margin-bottom 就是元素的下边距，相当于把排在下面的元素往下方移动了20个像素，px是单位，表示像素点*/
  }
</style>