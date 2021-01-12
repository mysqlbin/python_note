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

                <el-form-item label="schema: ">

                    <SchemaSearch v-model="searchBar.schema"></SchemaSearch>       
            
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
                         <span>{{ props.row.finger }}</span>
                        </el-form-item>

                    </el-form>
                </template>
            </el-table-column>
            
            <!-- 添加一列：执行时间2222 -->

            <el-table-column prop="schema" label="库名" width="100"></el-table-column>

            <el-table-column prop="slowlog_timestamp" :formatter="formatter" label="执行时间" width="220"></el-table-column>

            <el-table-column prop="ip" label="IP" width="150"></el-table-column>

            <el-table-column label='账号' width="200">
                <template slot-scope="scope">
                   {{ scope.row.slowlog_user }}@{{ scope.row.slowlog_ip }}
                </template>
            </el-table-column>

            <!-- <el-table-column prop="slowlog_host" label="ip" width="200"> 

            </el-table-column> -->
            
            <el-table-column prop="slowlog_query" label="SQL语句" width="450" :show-overflow-tooltip='true'> </el-table-column>

            <el-table-column prop="slowlog_rows_examined" label="扫描行数" width="100"></el-table-column>
            
            <el-table-column prop="slowlog_rows_sent" label="返回行数" width="100"></el-table-column>
            
            <el-table-column prop="slowlog_query_time_sec" label="执行时长(秒)" width="120">
                <template slot-scope="scope">
                    <span>{{ scope.row.slowlog_query_time_sec | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="slowlog_lock_time_sec" label="持有锁时长(秒)" width="150">
                <template slot-scope="scope">
                    <span>{{ scope.row.slowlog_lock_time_sec | numFilter }}</span>
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

    import SchemaSearch from '@/components/schema_search'
    import * as moment from 'moment'
    import {getSlowSqlList} from '@/api/slowsql'

    export default {
        name: "index",
        components: {SchemaSearch},
        data() {
            return {
                searchBar: {
                    schema: "",
                    page_size: 10,
                    page_num: 1,
                    start: "",
                    end: "",
                    is_aggr_by_hash: false,
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
            //  console.log("this.searchBar0: ", this.searchBar);     
            //  console.log("this.$route.query1:", this.$route.query)
            if (this.$route.query.page_num){
                   this.searchBar.page_num = parseInt(this.$route.query.page_num)    
            }

            if(this.$route.query.page_size){
                this.searchBar.page_size = parseInt(this.$route.query.page_size)     
            }    

            if(this.$route.query.hash){
                this.searchBar.hash = this.$route.query.hash
            }

            
            if(this.$route.query.start){
                         
                this.searchBar.start = this.$route.query.start 

            }

             if(this.$route.query.schema){

                this.searchBar.schema = this.$route.query.schema    

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

                if(to.query.hash){
                    this.searchBar.hash = to.query.hash  
                    console.log("to.query.hash: ", to.query.hash)   
                }

                if(to.query.start){
                    if ( this.searchBar.start != to.query.start){
                      this.searchBar.start = to.query.start      
                    }   
                }

                if(to.query.schema){
                    if ( this.searchBar.schema != to.query.schema){
                      this.searchBar.schema = to.query.schema       
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

                if(this.$route.query.schema){

                    this.searchBar.schema = this.$route.query.schema    

                }

                if(this.$route.query.end){
                    this.searchBar.end = this.$route.query.end
                    this.timeRange[1] = this.$route.query.end
                }else{
                    this.searchBar.end = moment(this.timeRange[1]).format();
                }
                
                getSlowSqlList(this.searchBar).then(resp => {
                    // console.log("resp: ", resp)
                    // console.log("resp: ", 111111)
                    this.total = resp.data.count
                    this.tableData = resp.data.results
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
                let timestamp = moment(row.slowlog_timestamp*1000).format("YYYY-MM-DD HH:mm:ss")// 2020-12-30 19:41:45  时间戳转时间
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