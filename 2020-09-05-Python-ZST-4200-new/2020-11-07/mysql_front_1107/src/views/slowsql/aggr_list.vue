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
                        <el-form-item label="完整的SQL语句：">
                         <span>{{ props.row.finger }}</span>
                        </el-form-item>

                    </el-form>
                </template>
            </el-table-column>

            <el-table-column prop="schema" label="库名" width="100"></el-table-column>

            
            <el-table-column prop="finger" label="SQL语句" width="500" :show-overflow-tooltip='true'> </el-table-column>


            <el-table-column prop="hash_count" label="执行总次数" width="130" sortable> </el-table-column>

            <el-table-column prop="queryTimeSum" label="执行总时长(秒)" width="150" sortable>
                <template slot-scope="scope">
                    <span>{{ scope.row.queryTimeSum | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="rowsExamineAvg" label="平均扫描行数" width="150">
                <template slot-scope="scope">
                    <span>{{ scope.row.rowsExamineAvg | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="rowsSentAvg" label="平均返回行数" width="150"> 
                <template slot-scope="scope">
                    <span>{{ scope.row.rowsSentAvg | numFilter }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="queryTimeAvg" label="平均执行时长(秒)" width="160"> 
                <template slot-scope="scope">
                    <span>{{ scope.row.queryTimeAvg | numFilter }}</span>
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
                    page_size: 5,
                    page_num: 1,
                    start: "",
                    end: "",
                    is_aggr_by_hash: true,
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
               
            //    console.log("row", row) 
            //    this.searchBar.hash = row.hash
            //    this.searchBar.is_aggr_by_hash = false
            //    console.log("this.searchBar", this.searchBar) 
               
                let routeUrl = this.$router.resolve({
                    path: '/slowsql/list',
                    query: {
                        start: this.searchBar.start,
                        end: this.searchBar.end,
                        schema: row.schema,
                        is_aggr_by_hash: false,
                        hash: row.hash
                    }
                });
                window.open(routeUrl.href, '_blank')

           },
            // 获取慢查询列表
            doSearch(){
                
                this.searchBar.start = moment(this.timeRange[0]).format();
                this.searchBar.end = moment(this.timeRange[1]).format();

                getSlowSqlList(this.searchBar).then(resp => {
                    // console.log("resp: ", resp)
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
            
           
        },

    }
</script>

<style lang="scss" scoped>
    .demo-form-inline {
        float: left;
    }
</style>