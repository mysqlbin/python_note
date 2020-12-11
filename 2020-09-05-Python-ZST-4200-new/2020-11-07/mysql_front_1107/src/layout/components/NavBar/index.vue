<template>
    <div class="nav-content">
        <div style="float: right;margin-right: 10px;">

            <el-dropdown >
              
                <span class="el-dropdown-link">
                    {{username}}<i class="el-icon-arrow-down el-icon--right"></i>
                </span>

                <el-dropdown-menu slot="dropdown">

                    <el-dropdown-item @click.native="logout">退出</el-dropdown-item>

                </el-dropdown-menu>

            </el-dropdown>
            
            <el-main>
                <router-view></router-view>
            </el-main>
     
        </div>
    </div>
</template>

<script>
    export default {
        name: "index",
        methods: {
        },
        computed: {
            username() {
                return this.$store.state.username
            }
        },
        methods: {
            logout(){
                logout().then(resp => {
                    console.log(resp)
                    let data = resp.data
                    if (data.code === 2000) {
                        this.$message.info('退出成功'); 
                        this.$store.commit('setUser',''); //更新setUser为空
                        this.$router.push('/login');
                    }else{

                       this.$message.error("无法退出") 

                    }
                }).catch(err => {
                    if (err) {
                        this.$message.error("无法连接服务器")
                    }
                })       
            }
        }
    }
</script>

<style scoped>
   
    .nav-content{
        width: 100%;
        height: 100%;
        position: relative;
        overflow: hidden;
        line-height: 60px;
    }
    .el-dropdown-link:hover{
        cursor: pointer;
    }


</style>
