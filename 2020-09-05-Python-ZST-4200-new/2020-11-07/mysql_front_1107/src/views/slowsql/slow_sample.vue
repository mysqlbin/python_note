<template>
    <div>
        <div id="container" style="width: 100%; height: 300px"></div>
        
        <el-row>
            <el-col :span="12">
                <div class="grid-content bg-purple">
                    <highcharts :options="schemaPieOptions"></highcharts>
                </div>
            </el-col>
            <el-col :span="12">
                <div class="grid-content bg-purple-light">
                    <el-table :data="tableData" border >
                         
                        <el-table-column prop="schema" label="库名" width="100"  type="expand">
                            <template slot-scope="props">
                                <el-form label-position="left" inline class="demo-table-expand">
                                    <el-form-item label="完整的SQL语句：">
                                        <span>{{ props.row.finger }}</span>
                                    </el-form-item>
                                </el-form>
                            </template>
                        </el-table-column>
                    
                        <el-table-column prop="finger" label="finger" width="500" :show-overflow-tooltip='true'>
                        </el-table-column>

                        <el-table-column prop="count" label="count" width="80"></el-table-column>
                        
                        <el-table-column label='操作'>
                            <template slot-scope="scope">
                                <el-button @click="showSlowSqlList(scope.row)" type="primary" size="small">查看慢日志明细</el-button>
                            </template>
                        </el-table-column>

                    </el-table>

                </div>
            </el-col>
        </el-row>



    </div>
</template>

<script>
import Highcharts from "highcharts";
import stockInit from "highcharts/modules/stock";
stockInit(Highcharts);

import { Chart } from "highcharts-vue";

import $ from "jquery";
import * as moment from 'moment'
import {getAggsByDate, getSlowSqlTop10, getAggsBySchema} from '@/api/slowsql'



export default {
    name: 'slow_sample',
    // 注册 highcharts
    components: {
        highcharts: Chart,
    },
    data(){
        return {
            tableData: [],
            queryParams: {
                start: "",
                end: "",
            },
            schemaPieOptions: {
                chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                },
                title: {
                        text: '各数据库慢SQL占比'
                },
                tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                        pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                        enabled: true,
                                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                        style: {
                                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                        }
                                }
                        }
                },
                series: [{
                        name: 'Brands',
                        colorByPoint: true,
                        data: []
                }]                   

            }
        }
    },
    created(){
        // console.log("created: ", 'created')

        this.updateQueryParams = _.debounce(
            function (startTime, endTime) {
                this.queryParams.start = startTime;
                this.queryParams.end = endTime;
                // console.log(this.queryParams);
                this.$emit("updateQueryParams");
            }.bind(this),
            1000
        );

        this.$on(
            "updateQueryParams",
            function () {
                this.doSearch();
            }.bind(this)
        );

    },
    mounted(){
        // console.log("mounted: ", 'mounted')
        this.createChart();
        this.doSearch();
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
                // console.log("es.resp: ", resp)    
                let chartData = [];
                // 组装数据，渲染到图表中
                _.forEach(resp.data, (v) => {
                    chartData.push([moment(v["date"]).utcOffset(480).unix() * 1000, v["date_count"]]);
                });
                console.log("chartData", chartData);

                this.stockChart = new Highcharts.stockChart("container", {

                    rangeSelector: {
                        // 时间范围按钮数组
                        buttons: [{
                            type: 'day',
                            count: 7,
                            text: '7d'
                        },{
                            type: 'month',
                            count: 1,
                            text: '1m'
                        }, {
                            type: 'month',
                            count: 3,
                            text: '3m'
                        }, {
                            type: 'month',
                            count: 6,
                            text: '6m'
                        }, {
                            type: 'ytd',
                            text: 'YTD'
                        }, {
                            type: 'year',
                            count: 1,
                            text: '1y'
                        }, {
                            type: 'all',
                            text: 'All'
                        }],
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
                        data: chartData,
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
            getSlowSqlTop10(this.queryParams).then(resp=> {
                this.tableData = resp.data;
            }),
            getAggsBySchema(this.queryParams).then((resp) => {
                const reducer = (accumulator, item) => accumulator + item["schema_count"];
                let countAll = resp.data.reduce(reducer, 0);
                // console.log("countAll: ", countAll);
                this.schemaPieOptions.series[0].data = resp.data.map((v) => {
                    return {
                        name: v["schema"],
                        y: v["schema_count"] / countAll,
                    };
                });

                // console.log("this.schemaPieOptions.series[0].data: ", this.schemaPieOptions.series[0].data);
            });
        },

        showSlowSqlList(row){
            
            // console.log("row", row) 
        //    this.searchBar.hash = row.hash
        //    this.searchBar.is_aggr_by_hash = false
            // console.log("this.searchBar", this.searchBar) 
            
            let routeUrl = this.$router.resolve({
                path: '/slowsql/list',
                query: {
                    start: this.queryParams.start,
                    end: this.queryParams.end,
                    schema: row.schema,
                    is_aggr_by_hash: false,
                    hash: row.hash
                }
            });
            window.open(routeUrl.href, '_blank')

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