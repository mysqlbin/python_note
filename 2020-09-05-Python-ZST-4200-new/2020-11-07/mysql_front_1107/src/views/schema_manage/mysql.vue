<template>
    <div>
         <el-form :inline="true" :model="searchBar" class="demo-form-inline">
                
            <el-form-item label="schema: ">

                <el-autocomplete
                        class="inline-input"
                        v-model="searchBar.schema"
                        :fetch-suggestions="querySearch"
                        placeholder="请输入库名"
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
        
        <el-table v-loading="tableLoading" :data="tableData" style="width: 100%">
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
                    prop="role"
                    label="角色"
                    width="180">
            </el-table-column>

            <el-table-column
                    prop="status"
                    label="状态"
                    width="180">
            </el-table-column>

             <el-table-column
                label="操作"
                width="100">
                <template slot-scope="scope">
                    <el-button @click="showProcessList(scope.row)" type="text" size="small">查看process list</el-button>
                </template>

            </el-table-column>
        </el-table>
        <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="searchBar.page_num"
            :page-sizes="[2, 5, 20, 100, 200, 500]"
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
                    page_size: 2,
                    page_num: 1,
                    
                },
                tableData: [],
                schemaNameList: [],
                tableLoading: false,
                total: 0,
            }
        },
        created() {
            getSchemaNameList().then(resp => {
                // if(resp.code === 2000) {
                this.schemaNameList = resp.data
                console.log("schemaNameList:", this.schemaNameList)
                // }
            })
            this.updateByQuery(this.$route)
            console.log("this_route: ", this.$route)

        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
            $route(to, from) {
                this.updateByQuery(to)
            }
        },
        methods: {
            // 获取url中的分页参数，根据query参数调整分页
            // http://127.0.0.1:8080/mysql?page_num=1&page_size=5 在新的窗口打开这个页面，会获取url中的分页参数，根据query参数调整分页

            updateByQuery(route){
                if(route.query.page_size) {
                    this.searchBar.page_size = parseInt(route.query.page_size)
                }
                if (route.query.page_num) {
                    this.searchBar.page_num = parseInt(route.query.page_num)
                }
                this.doSearch()
            },
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
                this.tableLoading = true
                getSchemaList(this.searchBar).then(resp => {
                    // 总共有多少行记录
                    this.total = resp.data.count
                    this.tableData = resp.data.results
                }).finally(_ => {
                    this.tableLoading = false
                })
            },
            // dialog弹窗
            // 这个方法是表格中，"查看process list" 按钮的click 回调函数
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
            },
            // 处理每页页数/大小变动
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`)
                let queryCopy = _.cloneDeep(this.$route.query)
                queryCopy.page_size = val
                this.updateRouteQuery(queryCopy)
            },
            // 处理当前页变动：点击上一页、下一页、前往第几页时生效
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`)
                let queryCopy = _.cloneDeep(this.$route.query)
                queryCopy.page_num = val
                this.updateRouteQuery(queryCopy)

            },
            // 更改url中的query参数
            updateRouteQuery(query) {
                console.log("query: ", query)
                this.$router.push({
                    //path: this.$route.path,
                    query: query
                }).catch(err => {})
            },

        },

    }
</script>

<style lang="scss" scoped>

</style>