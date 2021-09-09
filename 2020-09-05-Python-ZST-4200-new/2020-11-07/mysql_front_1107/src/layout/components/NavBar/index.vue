<template>
    <div class="nav-content">
        <div style="float: right;margin-right: 10px;">
            <el-dropdown >
                <span class="el-dropdown-link username">
                    {{username}}<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item @click.native="logout">退出</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </div>
    </div>
</template>

<script>
    import {logout} from '@/api/user'
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
                    let data = resp.data
                    if (data.code === 2000) {
                        this.$message.info('退出成功'); 
                        // 重置mutations setUser()的值为空
                        this.$store.commit('setUser',''); 
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
    .username:hover{
        cursor: pointer;
    }


</style>
