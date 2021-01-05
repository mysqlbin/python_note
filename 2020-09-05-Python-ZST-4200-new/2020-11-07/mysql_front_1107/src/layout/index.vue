<template>
    <el-container style="border: 1px solid #eee">
        <el-aside width="200px" style="background-color: rgb(238, 241, 246); ">
            <Sidebar></Sidebar>
        </el-aside>

        <el-container>
            <el-header style="text-align: right; font-size: 12px" class="nav">
                <Navbar></Navbar>
            </el-header>

            <el-main>
                <router-view></router-view>
            </el-main>

        </el-container>
    </el-container>
</template>

<script>

    import Sidebar from './components/Sidebar/index'
    import Navbar from './components/NavBar/index'
    export default {
        name: "index",
        components: { Sidebar, Navbar },
        computed: { // 计算属性
            
        },
        data() {
            return {
                
            }
        },
        created() {   
           
        },
        mounted(){
           
        },
        methods: {

        }   
    }
</script>

<style lang="scss" scoped>

    .el-header {
        background-color: #B3C0D1;
        color: #333;
        line-height: 60px;
    }

    .el-aside {
        color: #333;
    }
  


</style>

