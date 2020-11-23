<template>
    <div>
        <el-dialog
                title="提示"
                :visible.sync="dialogVisible"
                width="70%">
            <div>
                <p>
                    {{schema.host_ip}}-{{schema.port}}
                </p>
                <el-table
                        :data="processList"
                        border
                        height="250"
                        style="width: 100%;margin-bottom: 10px;">

                    <el-table-column
                            prop="id"
                            label="id"
                            sortable>
                    </el-table-column>

                    <el-table-column
                            prop="user"
                            label="user">
                    </el-table-column>
                    <el-table-column
                            prop="host"
                            label="host"
                            sortable>
                    </el-table-column>
                    <el-table-column
                            prop="db"
                            label="db">
                    </el-table-column>
                    <el-table-column
                            prop="command"
                            label="command">
                    </el-table-column>

                    <el-table-column
                            prop="time"
                            label="time"
                            sortable>
                    </el-table-column>

                    <el-table-column
                            prop="state"
                            label="state">
                    </el-table-column>

                    <el-table-column
                            prop="info"
                            label="info">
                    </el-table-column>

                    <el-table-column
                            label="操作">
                        <template slot-scope="scope">
                            <el-button type="text" size="small" :loading="scope.row.loading" >kill</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </div>

        </el-dialog>
    </div>
</template>

<script>
    import {getSchemaPorcesslist} from '../../api/schema_info'

    export default {
        name: "process_list",
        data() {
            return {
                dialogVisible: false,
                processList: [],
                schema: {}
            };
        },
        watch: {
            dialogVisible(){
                console.log('dialogVisible', this.dialogVisible)
            }
        },
        methods: {
            
            showProcessList(schema){
                this.schema = schema
                console.log("schema_id: ", schema.id)
                return new Promise((resolve) => {
                    getSchemaPorcesslist(schema.id).then(resp => {
                        this.processList = resp.data
                        _.forEach(this.processList, (v, k) => {
                            this.$set(this.processList[k], 'loading', false)
                        })
                        this.dialogVisible = true
                    }).catch(err => {
                        if (err) {
                            this.$message.error("无法获取process list")
                        }
                    }).finally(() => {
                        resolve()
                    })
                })
            }
        }
    }
</script>

<style scoped>

</style>