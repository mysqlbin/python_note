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
                    inactive-text="聚合">
                </el-switch>
                <el-tooltip class="item" effect="dark" content="选择聚合后，慢SQL将会按照指纹进行折叠" placement="top">
                    <i class="el-icon-question"></i>
                </el-tooltip>
            </div>

        </el-row>

        <el-table v-loading="tableLoading" :data="tableData" border style="width: 100%">
            <el-table-column
                prop="@timestamp"
                label="时间"
                width="180">
            </el-table-column>

            <el-table-column
                    prop="schema"
                    label="库名"
                    width="180">
            </el-table-column>

            <el-table-column
                    prop="host_ip"
                    label="实例"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="sql"
                    label="SQL">
            </el-table-column>

            <el-table-column
                    prop="role"
                    label="执行时间"
                    width="180">
            </el-table-column>

            <el-table-column
                    prop="status"
                    label="执行IP">
            </el-table-column>
    
        </el-table>
        <!-- <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="searchBar.page_num"
            :page-sizes="[2, 5, 20, 100, 200, 500]"
            :page-size="searchBar.page_size"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
        </el-pagination> -->
     
    </div>
</template>

<script>

    import SchemaSearch from '@/components/schema_search'
    import * as moment from 'moment'

    export default {
        name: "index",
        components: {SchemaSearch},
        data() {
            return {
                searchBar: {
                    schema: "",
                    page_size: 2,
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
          
        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           
        },
        methods: {
          
            // 获取慢查询列表
            doSearch(){
                
                // console.log('this.timeRange：',  this.timeRange)
                // console.log('this.timeRange[0]：',  this.timeRange[0])
                // console.log('this.timeRange[0].format：',  moment(this.timeRange[0]).format())
                // console.log('this.timeRange[1]：',  this.timeRange[1])
                this.searchBar.start = moment(this.timeRange[0]).format();
                this.searchBar.end = moment(this.timeRange[1]).format();

                console.log('searchBar: ', this.searchBar)

                
            },
           
           
        },

    }
</script>

<style lang="scss" scoped>
    .demo-form-inline {
        float: left;
    }
</style>