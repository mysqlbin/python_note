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

                <el-form-item label="实例名称: " style="width:300"> 

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
                        <el-form-item label="显示完整的SQL语句：">
                         <span>{{ props.row.SQLText }}</span>
                        </el-form-item>

                    </el-form>
                </template>
            </el-table-column>
            
            <el-table-column prop="HostnameMax" label="实例名称" width="180"></el-table-column>

            <el-table-column prop="ExecutionStartTime" :formatter="formatter" label="日志统计开始时间" width="170"></el-table-column>

            <el-table-column prop="ExecutionEndTime" :formatter="formatter" label="日志统计结束时间" width="170"></el-table-column>

            <el-table-column prop="HostAddress" label='用户名' width="200"></el-table-column>
            
            <el-table-column prop="SQLText" label="SQL语句" width="450" :show-overflow-tooltip='true'> </el-table-column>
            
            <el-table-column prop="TotalExecutionCounts" label="执行总次数" width="80" sortable></el-table-column>

            <el-table-column prop="QueryTimePct95" label="执行时长(95%)" width="100">
                 <template slot-scope="scope">
                    <span>{{ scope.row.QueryTimePct95 | numFilter }}</span>
                </template>
            </el-table-column>
            
            <el-table-column prop="QueryTimes" label="执行总时长(秒)" width="100" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.QueryTimes | numFilter }}</span>
                </template>
            </el-table-column>
            
            <el-table-column prop="LockTimes" label="持有锁总时长(秒)" width="100" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.LockTimes | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="ParseRowCounts" label="扫描总行数" width="150" sortable>
            </el-table-column>

             <el-table-column prop="ReturnRowCounts" label="返回总行数" width="150" sortable>
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
    import {getSlowSqlList} from '@/api/slowquery'
    export default {
        name: "index",
        components: {InstanceSearch},
        data() {
            return {
                searchBar: {
                    instance: "",
                    page_size: 10,
                    page_num: 1,
                    start: "",
                    end: "",
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
            //  console.log("this.searchBar0: ", this.searchBar);     
            //  console.log("this.$route.query1:", this.$route.query)
            // 用于url跳转之后重新获取参数
            if (this.$route.query.page_num){
                   this.searchBar.page_num = parseInt(this.$route.query.page_num)    
            }
            if(this.$route.query.page_size){
                this.searchBar.page_size = parseInt(this.$route.query.page_size)     
            }    
            if(this.$route.query.SQLId){
                this.searchBar.SQLId = this.$route.query.SQLId
            }
            
            if(this.$route.query.start){
                         
                this.searchBar.start = this.$route.query.start 
            }
            if(this.$route.query.instance){
                this.searchBar.instance = this.$route.query.instance    
            }
            if(this.$route.query.end){
                this.searchBar.end = this.$route.query.end
            }
                
            // console.log("this.searchBar1: ", this.searchBar);  
            this.doSearch()
        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           $route(to, from){
              
                if (to.query.page_num){
                   this.searchBar.page_num = parseInt(to.query.page_num)  
                    console.log("to.query.page_num: ", to.query.page_num)  
                }
                if(to.query.page_size){
                   this.searchBar.page_size = parseInt(to.query.page_size)   
                    console.log("to.query.page_size: ", to.query.page_size)  
                }    
                if(to.query.SQLId){
                    this.searchBar.SQLId = to.query.SQLId  
                    console.log("to.query.SQLId: ", to.query.SQLId)   
                }
                if(to.query.start){
                    if ( this.searchBar.start != to.query.start){
                      this.searchBar.start = to.query.start      
                    }   
                }
                if(to.query.instance){
                    if ( this.searchBar.instance != to.query.instance){
                      this.searchBar.instance = to.query.instance       
                    }   
                }
                if(to.query.end){
                    if (this.searchBar.end != to.query.end){
                      this.searchBar.end = to.query.end   
                    } 
                }
            //    console.log("this.searchBar2: ", this.searchBar);     
               this.doSearch()
           }
        },
        methods: {
          
            // 获取慢查询列表
            doSearch(){
                
                if(this.$route.query.start){
                           
                    this.searchBar.start = this.$route.query.start 
                    this.timeRange[0] = this.$route.query.start
                }else{
                    this.searchBar.start = moment(this.timeRange[0]).format();
                }
                if(this.$route.query.instance){
                    this.searchBar.instance = this.$route.query.instance    
                }
                if(this.$route.query.end){
                    this.searchBar.end = this.$route.query.end
                    this.timeRange[1] = this.$route.query.end
                }else{
                    this.searchBar.end = moment(this.timeRange[1]).format();
                }
                
                getSlowSqlList(this.searchBar).then(resp => {
                    console.log("resp: ", resp)
                    this.total = resp.data.total
                    this.tableData = resp.data.data
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
                let timestamp = moment(row.ExecutionStartTime).format("YYYY-MM-DD HH:mm:ss")// 2020-12-30 19:41:45  时间戳转时间
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