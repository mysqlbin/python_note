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

                <el-form-item label="实例名称: " > 

                    <InstanceSearch v-model="searchBar.instance"></InstanceSearch>       
            
                </el-form-item>


                <el-form-item label="SQLId: " > 

                    <SqlIdSearch v-model="searchBar.sqlid"></SqlIdSearch>       
            
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
                        <el-form-item label="SQLId：">
                            <span>{{ props.row.SQLId }}</span>
                        </el-form-item>
                        <el-form-item label="显示完整的SQL语句：">
                            <span>{{ props.row.SQLText }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            
            <el-table-column prop="HostnameMax" label="实例名称" width="180"></el-table-column>

            <el-table-column prop="ExecutionStartTime" :formatter="formatter" label="本次统计的第一次执行时间" width="170"></el-table-column>

            <el-table-column prop="ExecutionEndTime" :formatter="formatter" label="本次统计的最一次执行时间" width="170"></el-table-column>

            <el-table-column prop="HostAddress" label='用户名' width="200"></el-table-column>
            
            <el-table-column prop="SQLText" label="SQL语句" width="450" :show-overflow-tooltip='true'> </el-table-column>
            
            <el-table-column prop="TotalExecutionCounts" label="执行总次数" width="80" sortable></el-table-column>

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

            <el-table-column prop="ParseRowCounts" label="扫描总行数" width="120" sortable>
            </el-table-column>

             <el-table-column prop="ReturnRowCounts" label="返回总行数" width="120" sortable>
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
    import SqlIdSearch from '@/components/checksum_search'
    import * as moment from 'moment'
    import {getSlowSqlList} from '@/api/slowquery'
    export default {
        name: "index",
        components: {InstanceSearch, SqlIdSearch},
        data() {
            return {
                searchBar: {
                    instance: "",
                    sqlid: "",
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
           
            // 获取通过url跳转到当前页面后的参数
            if (this.$route.query.page_num){
                   this.searchBar.page_num = parseInt(this.$route.query.page_num)    
            }
            if(this.$route.query.page_size){
                this.searchBar.page_size = parseInt(this.$route.query.page_size)     
            }    
            if(this.$route.query.sqlid){
                this.searchBar.sqlid = this.$route.query.sqlid
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
            
            // 页面加载，就触发搜索功能
            this.doSearch()
            //当从聚合列表点击进来查看详情后，清空地址栏参数
            // this.$router.push({ query: {} });  
            if(this.$route.query.sqlid){
               this.$router.replace({ query: {} })     
            }
            
                   
        },
        // 侦听事件，监听路由的变化，不加这个，点击上一页、下一页不生效
        watch: {
           $route(to, from){
                
                if (to.query.page_num){
                   this.searchBar.page_num = parseInt(to.query.page_num)     
                }
                if(to.query.page_size){
                   this.searchBar.page_size = parseInt(to.query.page_size)   
                }    
                if(to.query.sqlid){
                    if (this.searchBar.sqlid != to.query.sqlid){
                        this.searchBar.sqlid = to.query.sqlid   
                    } 
                }
                if(to.query.instance){
                    if (this.searchBar.instance != to.query.instance){
                        this.searchBar.instance = to.query.instance   
                    }   
                }
                if(to.query.start){
                    if (this.searchBar.start != to.query.start){
                      this.searchBar.start = to.query.start      
                    }   
                }
                if(to.query.end){
                    if (this.searchBar.end != to.query.end){
                      this.searchBar.end = to.query.end   
                    } 
                }   
               this.doSearch()
           }
        },
        methods: {
          
            // 获取慢查询列表, 点击搜索按钮时触发
            doSearch(){
                
                if(this.$route.query.start){
                    this.searchBar.start = this.$route.query.start   // 把url start参数绑定到服务端请求参数中
                    this.timeRange[0] = this.$route.query.start      // 开始时间为url start参数的值
                }else{
                    this.searchBar.start = moment(this.timeRange[0]).format();
                }
                if(this.$route.query.end){
                    this.searchBar.end = this.$route.query.end
                    this.timeRange[1] = this.$route.query.end
                }else{
                    this.searchBar.end = moment(this.timeRange[1]).format();
                }
                
                if(this.$route.query.instance){
                    this.searchBar.instance = this.$route.query.instance   
                }
                getSlowSqlList(this.searchBar).then(resp => {
                    this.total = resp.data.total
                    this.tableData = resp.data.data
                }).finally(_ => {
                    // this.tableLoading = false
                })
            },
            handleSizeChange(val) {
                let queryCopy = _.cloneDeep(this.$route.query)
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