<template>

    <div id="container" style="width: 100%; height: 300px"></div>
    
</template>

<script>
import Highcharts from "highcharts";
import stockInit from "highcharts/modules/stock";
stockInit(Highcharts);
import $ from "jquery";
import * as moment from 'moment'

export default {
    name: 'slow_sample',
    data(){
        return {
        }
    },
    created(){
        console.log("created: ", 'created')

        this.updateQueryParams = _.debounce(
            function (startTime, endTime) {
                this.queryParams.start = startTime;
                this.queryParams.end = endTime;
                console.log(this.queryParams);
                this.$emit("updateQueryParams");
            }.bind(this),
            1000
        );

        this.$on(
            "updateQueryParams",
            function () {
                console.log("query params has changed");
                // this.doSearch();
            }.bind(this)
        );

    },
    mounted(){
        console.log("mounted: ", 'mounted')
        this.createChart();
    },
    methods: {

        createChart() {
            let that = this;
            Highcharts.setOptions({
                lang: {
                    rangeSelectorZoom: "",
                },
            });

            getAggsByDate(this.queryParams).then((resp) => {

                let chartData = [];
                // 组装数据，渲染到图表中
                _.forEach(resp.data, (v) => {
                    chartData.push([moment(v["date"]).unix() * 1000, v["date_count"]]);
                });
                console.log("chartData", chartData);

                this.stockChart = new Highcharts.stockChart("container", {

                    rangeSelector: {
                        selected: 1
                    },
                    title: {
                        text: '每日慢SQL数量'
                    },
                    xAxis: {
                        events: {
                            // 监听时间范围的变化
                            afterSetExtremes: function (e) {
                                // e.min 和 e.max 为坐标轴当前的范围
                                console.log(e.min, e.max);
                                let startTime = _.toInteger(e.min) / 1000;
                                let endTime = _.toInteger(e.max) / 1000;
                                startTime = moment.unix(startTime).format();
                                endTime = moment.unix(endTime).format();
                                console.log("startTime: ", startTime);
                                console.log("endTime: ", endTime);
                                that.updateQueryParams(startTime, endTime);
                            },
                        },
                    },
                    series: [{
                        name: '数量',
                        data: data,
                        type: 'spline',
                        tooltip: {
                            valueDecimals: 2
                        }
                    }],
                    
                });

            })


            // $.getJSON('https://data.jianshukeji.com/jsonp?filename=json/aapl-c.json&callback=?', function (data) {
                



        },
        doSearch(){
            getTop10(this.queryParams).then(resp=> {
                this.tableData = resp.data
            })
        },

        // createChart() {
            
        //     Highcharts.setOptions({
        //         lang: {
        //             rangeSelectorZoom: "",
        //         },
        //     });

        //     // $.getJSON('https://data.jianshukeji.com/jsonp?filename=json/aapl-c.json&callback=?', function (data) {
        //     $.getJSON('https://demo-live-data.highcharts.com/aapl-c.json', function (data) {
        //         // Create the chart
        //         Highcharts.stockChart('container',  {
        //             rangeSelector: {
        //                 selected: 1
        //             },
        //             title: {
        //                 text: 'AAPL Stock Price'
        //             },
        //             xAxis: {
        //                 events: {
        //                 // 监听时间范围的变化
        //                 afterSetExtremes: function (e) {
        //                     // e.min 和 e.max 为坐标轴当前的范围
        //                     console.log(e.min, e.max);
        //                     let startTime = _.toInteger(e.min) / 1000;
        //                     let endTime = _.toInteger(e.max) / 1000;
        //                     startTime = moment.unix(startTime).format();
        //                     endTime = moment.unix(endTime).format();
        //                     console.log("startTime: ", startTime);
        //                     console.log("endTime: ", endTime);
        //                 },
        //                 },
        //             },
        //             series: [{
        //                 name: 'AAPL Stock Price',
        //                 data: data,
        //                 type: 'spline',
        //                 tooltip: {
        //                     valueDecimals: 2
        //                 }
        //             }],
                    
        //         });

        //         console.log("data: ", data)
        //     });
        // },
    
    }
}
</script>

<style scoped>
  
</style>