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
                <el-button type="primary" >查询</el-button>
            </el-form-item>

        </el-form>
        
        <el-table
        :data="tableData"
        style="width: 100%">
        <el-table-column
            prop="date"
            label="日期1"
            width="180">
        </el-table-column>
        <el-table-column
            prop="name"
            label="姓名"
            width="180">
        </el-table-column>
        <el-table-column
            prop="address"
            label="地址">
        </el-table-column>
        </el-table>
        </div>
</template>

<script>

    import {getSchemaNameList, getSchemas} from '../..//api/schema_info'

    export default {
        name: "index",
        
        data() {
            return {
                searchBar: {
                    schema: "",
                    tableData: []
                },
                schemaList: []
            }
        },
        created() {
            getSchemaNameList().then(resp => {
                
                // if(resp.code === 2000) {
                this.schemaList = resp.data
                console.log(this.schemaList)
                console.log(1111111)   
                // }
            })
        },
        methods: {
            querySearch(queryString, cb) {
                let results = this.schemaList.filter(s => {
                    return queryString ? s.toLocaleLowerCase().indexOf(queryString.toLowerCase()) > -1 : true
                }).map(s => {
                    return {value: s}
                })
                cb(results)
            },
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