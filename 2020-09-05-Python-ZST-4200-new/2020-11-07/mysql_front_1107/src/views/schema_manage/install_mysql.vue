<template>
    <div>

        <el-dialog title="安装MySQL" :visible.sync="dialogVisible" width="500px">
           
            <el-form :model="formInstall" :rules="rules" ref="ruleForm">

                <el-form-item label="host_ip：" :label-width="formLabelWidth" prop="host_ip">
                    <el-input v-model="formInstall.host_ip"  placeholder="请输入IP地址" name="host_ip"></el-input>
                </el-form-item>
                
                <el-form-item label="port：" :label-width="formLabelWidth"  prop="port">
                    <el-input v-model="formInstall.port"  placeholder="请输入端口号" name="port" ></el-input>
                </el-form-item>
                
                <el-form-item label="schema：" :label-width="formLabelWidth"  prop="schema">
                    <el-input v-model="formInstall.schema" placeholder="请输入库名" name="schema" ></el-input>
                </el-form-item>

                <el-form-item>
                    <el-button :loading="loading" type="primary" @click.native.prevent="handleInstall('ruleForm')">确定</el-button>
                </el-form-item>

            </el-form>

        </el-dialog>
    </div>
              
</template>

<script>
   export default {
    name: "install_mysql",
    data() {
      return {
        loading: false,
        formInstall: {
          host_ip: "",
          port: 3306,
          schema: "",
        }, 
        dialogVisible: false,
        formLabelWidth: '100px',
        rules: {
                host_ip: [
                    { required: true, message: '请输入IP地址', trigger: 'blur' },
                ],
                port: [
                    { required: true, type: "integer", min:3305, max: 65535, message: '请输入正确的端口', trigger: 'blur' }
                ],
                schema: [
                    { required: true, type: 'string', message: '请输入库名', trigger: 'blur'}
                ]
            }
      };
    },
    methods: {
        show(){
            console.log("debug: ", 1111)
            this.dialogVisible = true
        },
        handleInstall(ruleForm){
            this.$refs[ruleForm].validate((valid) => {
                if (valid) {
                    this.loading = true   // 表示在加载中
                    console.log(1)    
                }else{
                    this.$message.error('请正确填写表单')
                    return false;
                }
            })
            
        }
    }
   }
</script>

<style scoped>

</style>