<template>
    <div>
        <div id="container" style="width: 100%; height: 300px"></div>
        
        <el-row>
            <el-col :span="10">
                <div class="grid-content bg-purple">
                    <highcharts :options="schemaPieOptions"></highcharts>
                </div>
            </el-col>

            <el-col :span="14">
                <div class="grid-content bg-purple-light">
                    <el-table :data="tableData" border >
                         
                        <el-table-column type="expand">
                            <template slot-scope="props">
                                <el-form label-position="left" inline class="demo-table-expand">
                                    <el-form-item label="完整的SQL语句：">
                                        <span>{{ props.row.FingerPrint }}</span>
                                    </el-form-item>
                                </el-form>
                            </template>
                        </el-table-column>

                        <el-table-column prop="HostnameMax" label="实例名称" width="200"></el-table-column>

                        <el-table-column prop="FingerPrint" label="finger" width="350" :show-overflow-tooltip='true'></el-table-column>

                        <el-table-column prop="MySQLTotalExecutionCounts" label="count" width="80"></el-table-column>
                        
                        <el-table-column label='操作'>
                            <template slot-scope="scope">
                                <el-button @click="showSlowQueryList(scope.row)" type="primary" size="small">查看慢日志明细</el-button>
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
import {getAggsByDate, getAggsByInstance, getSlowSqlTop10} from '@/api/slowquery'



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
                        text: '各实例/数据库慢SQL占比'
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
                console.log(this.queryParams);
                this.$emit("updateQueryParams");
            }.bind(this),
            1000
        );

        this.$on(
            "updateQueryParams",
            function () {
                // console.log("query params has changed");
                // console.log("this.queryParams.start: ", this.queryParams.start)
                // console.log("this.queryParams.end: ", this.queryParams.end)
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
                console.log("resp", resp.data);   
                let chartData = [];
                // 组装数据，渲染到图表中
                _.forEach(resp.data.data, (v) => {
                    // chartData.push([v["byday"], v["date_count"]]);
                    chartData.push([moment(v["byday"]).unix() * 1000, v["date_count"]]);
                });
                console.log("chartData", chartData);

                this.stockChart = new Highcharts.stockChart("container", {

                    rangeSelector: {
                        // 时间范围按钮数组
                        // buttons: [new Date() - 3600 * 1000 * 24 * 30, new Date()],

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
                console.log("resp_top10: ", resp.data.date.start)
                // console.log("this.queryParams.start: ", this.queryParams.start)
                // console.log("this.queryParams.end: ", this.queryParams.end)
                this.queryParams.start = resp.data.date.start
                this.queryParams.end = resp.data.date.end
                this.tableData = resp.data.data;
                // console.log("tableData: ", resp.data)
            }),
            getAggsByInstance(this.queryParams).then((resp) => {
                const reducer = (accumulator, item) => accumulator + item["instance_slow_count"];
                let countAll = resp.data.data.reduce(reducer, 0);
                // console.log("countAll: ", countAll);
                this.schemaPieOptions.series[0].data = resp.data.data.map((v) => {
                    return {
                        name: v["hostname_max"],
                        y: v["instance_slow_count"] / countAll,
                    };
                });

                // console.log("this.schemaPieOptions.series[0].data: ", this.schemaPieOptions.series[0].data);
            });
        },

        showSlowQueryList(row){
            console.log("row", row) 
            console.log("queryParams", this.queryParams) 
            let routeUrl = this.$router.resolve({
                path: '/slowquery/list',
                query: {
                    start: this.queryParams.start,
                    end: this.queryParams.end,
                    schema: row.schema,
                    SQLId: row.SQLId,
                }
            });
            window.open(routeUrl.href, '_blank')

        },
    }
}
</script>

<style scoped>
  
</style>