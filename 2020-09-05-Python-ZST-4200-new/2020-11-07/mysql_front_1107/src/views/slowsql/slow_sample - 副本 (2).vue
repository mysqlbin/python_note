<template>
  <div class="login-container">
    
    <div id="main" style="width: 100%; height: 300px"></div>

  </div>
</template>

<script>

  export default {
    name: 'slow_sample',
    data(){
      return {
  

      }
    },
    created(){
      // console.log('created')
        
    },
    mounted(){
      // console.log("mounted")
      this.drawChart()
    },
    methods: {
     
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

  .login-form{
 
    width: 520px;
    max-width: 100%;  /*当移动端的宽度没有520px，那么就使用max-width: 100%; 占满整个屏幕的宽度*/
    margin: 0 auto;
    padding: 160px 35px 0;
 
  }

</style>