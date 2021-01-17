<template>
    <div>
        <el-row type="flex" class="row-bg" justify="space-between">
            <el-form :inline="true" :model="searchBar" class="demo-form-inline">

                <el-form-item label="时间范围: ">
                    <el-date-picker
                        v-model="timeRange"
                        type="datetimerange"
                        :picker-options="pickerOptions"
                        range-separator="至"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                        align="right">
                    </el-date-picker>
                  
                </el-form-item>

                <el-form-item label="实例名: ">

                    <InstanceSearch v-model="searchBar.instance"></InstanceSearch>       
            
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="doSearch">查询</el-button>
                </el-form-item>

            </el-form>

        </el-row>

        <el-table v-loading="tableLoading" :data="tableData" border style="width: 100%">

            <el-table-column type="expand">
                <template slot-scope="props">
                    <el-form label-position="left" inline class="demo-table-expand">
                        <el-form-item label="完整的SQL语句：">
                         <span>{{ props.row.SQLText }}</span>
                        </el-form-item>

                    </el-form>
                </template>
            </el-table-column>

            <el-table-column prop="CreateTime" label="日志统计时间" :formatter="formatter" width="180"></el-table-column>

            <el-table-column prop="DBName" label="实例名称" width="180"></el-table-column>

            <el-table-column prop="SQLText" label="SQL语句" width="300" :show-overflow-tooltip='true'> </el-table-column>


            <el-table-column prop="MySQLTotalExecutionCounts" label="执行总次数" width="100" sortable> </el-table-column>

            <el-table-column prop="MySQLTotalExecutionTimes" label="执行总时长(秒)" width="100" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.MySQLTotalExecutionTimes | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="QueryTimeAvg" label="平均执行时长(秒)" width="100" sortable> 
                <template slot-scope="scope">
                    <span>{{ scope.row.QueryTimeAvg | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="ParseTotalRowCounts" label="扫描总行数" width="120" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.ParseTotalRowCounts | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="ParseRowAvg" label="平均扫描行数" width="120" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.ParseRowAvg | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="ReturnTotalRowCounts" label="返回总行数" width="150" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.ReturnTotalRowCounts | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="ReturnRowAvg" label="平均返回行数" width="100" sortable> 
                <template slot-scope="scope">
                    <span>{{ scope.row.ReturnRowAvg | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column label='操作'>
                <template slot-scope="scope">
                    <!-- {{ scope.row }} -->
                   <el-button @click="showSlowSqlList(scope.row)" type="primary" size="small">查看慢日志明细</el-button>
                
                </template>
            </el-table-column>

        </el-table>
        <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="searchBar.page_num"
            :page-sizes="[5, 10, 20, 100, 200, 500]"
            :page-size="searchBar.page_size"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
        </el-pagination>
     
    </div>
</template>

<script>

     import InstanceSearch from '@/components/instance_search'
    import * as moment from 'moment'
    import {getSlowSqlAggrList} from '@/api/slowquery'

    export default {
        name: "index",
        components: {InstanceSearch},
        data() {
            return {
                searchBar: {
                    instance: "",
                    page_size: 5,
                    page_num: 1,
                    start: "",
                    end: "",
                    hash: "",
                    
                },
                tableData: [],
                schemaNameList: [],
                tableLoading: false,
                total: 0,
                timeRange: [new Date() - 3600 * 1000 * 24 * 30, new Date()],
                pickerOptions: {
                    shortcuts: [{
                        text: '最近一周',
                        onClick(picker) {
                        const end = new Date();
                        const start = new Date();
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                        picker.$emit('pick', [start, end]);
                        }
                    }, {
                        text: '最近一个月',
                        onClick(picker) {
                        const end = new Date();
                        const start = new Date();
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                        picker.$emit('pick', [start, end]);
                        }
                    }, {
                        text: '最近三个月',
                        onClick(picker) {
                        const end = new Date();
                        const start = new Date();
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                        picker.$emit('pick', [start, end]);
                        }
                    }]
                },
            }
        },
        filters: {
            // 截取当前数据到小数点后两位
            numFilter(value) {
                let realVal = parseFloat(value).toFixed(2);
                return realVal;
            },
        },
        created() {
            //  console.log("created: ", 'created')      
            if (this.$route.query.page_num){
                   this.searchBar.page_num = parseInt(this.$route.query.page_num)    
            }

            if(this.$route.query.page_size){
                this.searchBar.page_size = parseInt(this.$route.query.page_size)     
            }    

            this.doSearch()

        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           $route(to, from){
              
                if (to.query.page_num){
                   this.searchBar.page_num = parseInt(to.query.page_num)  
                    // console.log("to.query.page_num: ", to.query.page_num)  
                }

                if(to.query.page_size){
                   this.searchBar.page_size = parseInt(to.query.page_size)   
                    // console.log("to.query.page_size: ", to.query.page_size)  
                }    

               this.doSearch()

           }
        },
        methods: {
           showSlowSqlList(row){

               console.log("row", row) 
                           
                let routeUrl = this.$router.resolve({
                    path: '/slowquery/list',
                    query: {
                        start: this.searchBar.start,
                        end: this.searchBar.end,
                        schema: row.schema,
                        SQLId: row.SQLId
                    }
                });
                window.open(routeUrl.href, '_blank')

           },
            // 获取慢查询列表
            doSearch(){
                
                this.searchBar.start = moment(this.timeRange[0]).format();
                this.searchBar.end = moment(this.timeRange[1]).format();

                console.log("this.searchBar", this.searchBar) 

                getSlowSqlAggrList(this.searchBar).then(resp => {
                    console.log("resp: ", resp.data.data)
                    this.total = resp.data.total
                    this.tableData = resp.data.data
                    // 总共有多少行记录
                    // this.total = resp.data.count
                    // this.tableData = resp.data.results
                }).finally(_ => {
                    // this.tableLoading = false
                })
            },

            handleSizeChange(val) {

                // console.log(`每页 ${val} 条`);
                
                // this.searchBar.page_size = val
                // this.doSearch()

                let queryCopy = _.cloneDeep(this.$route.query)
                // console.log("queryCopy: ", queryCopy)
                queryCopy.page_size = val

                // 修改 url
                this.$router.push({

                    query: queryCopy

                }).catch(err => {})


            },
            handleCurrentChange(val) {
                // console.log(`当前页: ${val}`);

                // 这种方式也可以实现分页改变之后的数据变化，不过不完善
                // this.searchBar.page_num = val 
                // this.doSearch()

                let queryCopy = _.cloneDeep(this.$route.query)
                // console.log("queryCopy: ", queryCopy)
                queryCopy.page_num = val
                // 修改 url
                this.$router.push({

                    query: queryCopy
                    
                }).catch(err => {})

            },
            formatter(row, column) {
            
                // console.log("timestamp: ", row.slowlog_timestamp);
                let timestamp = moment(row.slowlCreateTimeog_timestamp).format("YYYY-MM-DD HH:mm:ss")// 2020-12-30 19:41:45  时间戳转时间
                return timestamp;
            },
            
            
           
        },

    }
</script>

<style lang="scss" scoped>
    .demo-form-inline {
        float: left;
    }
</style>