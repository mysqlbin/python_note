<template>
    <div>
         <el-form :inline="true" :model="searchBar" class="demo-form-inline">
                
            <el-form-item label="schema">

                <el-autocomplete
                        class="inline-input"
                        v-model="searchBar.schema"
                        :fetch-suggestions="querySearch"
                        placeholder="请输入内容"
                ></el-autocomplete>

            </el-form-item>

            <!-- <el-form-item label="状态">
                <el-select v-model="searchBar.status" placeholder="实例状态" clearable>
                    <el-option label="上线" value="online"></el-option>
                    <el-option label="装机中" value="pending"></el-option>
                    <el-option label="下线" value="offline"></el-option>
                </el-select>
            </el-form-item> -->

            <el-form-item>
                <el-button type="primary" @click="doSearch">查询</el-button>
            </el-form-item>

        </el-form>
        
        <el-table :data="tableData" style="width: 100%">
            <el-table-column
                    prop="schema"
                    label="库名"
                    width="180">
            </el-table-column>

            <el-table-column
                    prop="host_ip"
                    label="ip"
                    width="180">
            </el-table-column>
			
            <el-table-column
                    prop="port"
                    label="端口"
                    width="180">
            </el-table-column>

             <el-table-column
                label="操作"
                width="100">
                <template slot-scope="scope">
                    <el-button @click="showProcessList(scope.row)" type="text" size="small">查看process</el-button>
                </template>

            </el-table-column>
        </el-table>
        <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="searchBar.page_num"
            :page-sizes="[5, 20, 100, 200, 500]"
            :page-size="searchBar.page_size"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
        </el-pagination>
         <ProcessListDialog ref="process_list_dialog"></ProcessListDialog>
         
        </div>
</template>

<script>

    import {getSchemaNameList, getSchemaList} from '../../api/schema_info'
    import ProcessListDialog from './process_list'
    export default {
        name: "index",
        components: {ProcessListDialog},
        data() {
            return {
                searchBar: {
                    schema: "",
                    page_size: 100,
                    page_num: 1,
                },
                tableData: [],
                schemaNameList: [],
                tableLoading: false,
            }
        },
        created() {
            getSchemaNameList().then(resp => {
                // if(resp.code === 2000) {
                this.schemaNameList = resp.data
                console.log("schemaNameList:", this.schemaNameList)
                // }
            })

            this.doSearch()

        },
        methods: {
            // 库名的搜索功能
            querySearch(queryString, cb) {
                let schemaNameList = this.schemaNameList
                let results = schemaNameList.filter(s => {
                    return queryString ? s.toLocaleLowerCase().indexOf(queryString.toLowerCase()) > -1 : true
                }).map(s => {
                    return {value: s}
                })
                console.log(results)
                cb(results)
            },
            // 获取实例列表
            doSearch(){
                console.log('do search')
                console.log('searchBar: ', this.searchBar )
                getSchemaList(this.searchBar).then(resp => {
                    // 总共有多少行记录
                    this.total = resp.data.count
                    this.tableData = resp.data.results
                }).finally(_ => {
                    this.tableLoading = false
                })
            },
            // dialog弹窗
            showProcessList(row){
                const loading = this.$loading({
                    lock: true,
                    text: 'Loading',
                    spinner: 'el-icon-loading',
                    background: 'rgba(0, 0, 0, 0.7)'
                });
                this.$refs.process_list_dialog.showProcessList(row).then(_ => {
                    loading.close();
                })
            }

            // querySearch(queryString, cb) {
            //     var schemaList = this.schemaList;
            //     var results = queryString ? schemaList.filter(this.createFilter(queryString)) : schemaList;
            //     // 调用 callback 返回建议列表的数据
            //     cb(results);
            // },
            // createFilter(queryString) {
            //     return (schemaList) => {
            //     return (schemaList.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
            // };

        },
    //     data() {
    //         return {
    //         tableData: [{
    //             date: '2016-05-02',
    //             name: '王小虎1',
    //             address: '上海市普陀区金沙江路 1518 弄'
    //         }, {
    //             date: '2016-05-04',
    //             name: '王小虎',
    //             address: '上海市普陀区金沙江路 1517 弄'
    //         }, {
    //             date: '2016-05-01',
    //             name: '王小虎',
    //             address: '上海市普陀区金沙江路 1519 弄'
    //         }, {
    //             date: '2016-05-03',
    //             name: '王小虎',
    //             address: '上海市普陀区金沙江路 1516 弄'
    //         }]
    //         }
    //   }
    }
</script>

<style lang="scss" scoped>

</style>