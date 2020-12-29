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

            <div>
                <el-switch
                    v-model="searchBar.is_aggr_by_hash"
                    active-text="不聚合"
                    inactive-text="聚合"
                    @change="doSearch"
                    >
                </el-switch>
                <el-tooltip class="item" effect="dark" content="选择聚合后，慢SQL将会按照指纹进行折叠" placement="top">
                    <i class="el-icon-question"></i>
                </el-tooltip>
            </div>

        </el-row>

        <el-table v-loading="tableLoading" :data="tableData" border style="width: 100%">


            <el-table-column prop="schema" label="库名" width="100"></el-table-column>

            <!-- <el-table-column prop="host" label="ip" width="180"> </el-table-column> -->


            <el-table-column :label="searchBar.is_aggr_by_hash ? '数量': 'ip'" width="150">
                <template slot-scope="scope">
                <div v-if="searchBar.is_aggr_by_hash">
                    {{ scope.row.hash_count }}
                </div>
                <div v-else>
                    {{ scope.row.host }}
                </div>
                </template>
            </el-table-column>

            <el-table-column prop="finger" label="sql" > </el-table-column>

            <!-- <el-table-column prop="query_time" label="query_time"></el-table-column> -->

            <!-- <el-table-column prop="rows_examined" label="rows_examined"></el-table-column> -->

            <el-table-column :label="searchBar.is_aggr_by_hash ? 'rowsExamineAvg': 'rows_examined'" width="100">
                <template slot-scope="scope">
                <div v-if="searchBar.is_aggr_by_hash">
                    {{ scope.row.rowsExamineAvg }}
                </div>
                <div v-else>
                    {{ scope.row.rows_examined }}
                </div>
                </template>
            </el-table-column>

            <el-table-column :label="searchBar.is_aggr_by_hash ? 'rowsSentAvg': 'rows_sent'" width="100">
                <template slot-scope="scope">
                <div v-if="searchBar.is_aggr_by_hash">
                    {{ scope.row.rowsSentAvg }}
                </div>
                <div v-else>
                    {{ scope.row.rows_sent }}
                </div>
                </template>
            </el-table-column>

            <!-- <el-table-column prop="rows_sent" label="rows_sent"></el-table-column> -->



            <el-table-column :label="searchBar.is_aggr_by_hash ? 'queryTimeAvg': 'query_time'" width="100">
                <template slot-scope="scope">
                <div v-if="searchBar.is_aggr_by_hash">
                    {{ scope.row.queryTimeAvg }}
                </div>
                <div v-else>
                    {{ scope.row.query_time }}
                </div>
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
    import {getSlowSqlList} from '../../api/slowsql'

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
                    is_aggr_by_hash: false,
                    
                },
                tableData: [],
                schemaNameList: [],
                tableLoading: false,
                total: 0,
                timeRange: [new Date() - 3600 * 1000 * 24 * 7, new Date()],
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
        created() {

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
                    console.log("to.query.page_num: ", to.query.page_num)  
                }

                if(to.query.page_size){
                   this.searchBar.page_size = parseInt(to.query.page_size)   
                    console.log("to.query.page_size: ", to.query.page_size)  
                }    

               this.doSearch()

           }
        },
        methods: {
          
            // 获取慢查询列表
            doSearch(){
                
                this.searchBar.start = moment(this.timeRange[0]).format();
                this.searchBar.end = moment(this.timeRange[1]).format();

                getSlowSqlList(this.searchBar).then(resp => {
                    console.log("resp: ", resp)
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

                console.log(`每页 ${val} 条`);
                
                // this.searchBar.page_size = val
                // this.doSearch()

                let queryCopy = _.cloneDeep(this.$route.query)
                console.log("queryCopy: ", queryCopy)
                queryCopy.page_size = val

                // 修改 url
                this.$router.push({

                    query: queryCopy

                }).catch(err => {})


            },
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);

                // 这种方式也可以实现分页改变之后的数据变化，不过不完善
                // this.searchBar.page_num = val 
                // this.doSearch()

                let queryCopy = _.cloneDeep(this.$route.query)
                console.log("queryCopy: ", queryCopy)
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