<template>
    <div>
        <el-container style="border: 1px solid #eee">
        <el-aside width="200px" style="height: 100%; overflow: scroll; background-color: rgb(238, 241, 246)">
            <el-menu :default-active="routePath" :default-openeds="['1', '3']">
                 <div v-for="(submenu, key) in menuRouts" :key="key">
                        <!-- {{submenu.path}} -->
                    <template v-if="!submenu.children || submenu.children.length == 0">
                        <el-menu-item :index="resolvePath('/', submenu.path)">
                            {{routeName(submenu)}}
                        </el-menu-item>
                    </template>

                    <template v-else>

                        <el-submenu :index="resolvePath('/', submenu.path)">
                            <template slot="title">
                                <i class="el-icon-location"></i>
                                <span>{{routeName(submenu)}}</span>
                            </template>

                            <el-menu-item-group>
                                <el-menu-item v-for="(child, cKey) in submenu.children" :key="cKey">
                                    <router-link :to="child.path">{{routeName(child)}}</router-link>
                                </el-menu-item>
                            </el-menu-item-group>

                        </el-submenu>
                    </template>

                </div>
                <!-- <el-submenu v-for="(submenu, key) in menuRouts" :key="key">
                    <template slot="title">
                        <i class="el-icon-location"></i>
                        <span>{{ submenu.meta ? submenu.meta.title : 'no title' }}</span>
                    </template>

                    <el-menu-item-group>
                        <el-menu-item v-for="(child, cKey) in submenu.children" :key="cKey">
                            <router-link :to="child.path">{{ child.meta ? child.meta.title : 'no title' }}</router-link>
                        </el-menu-item>
                    </el-menu-item-group>
                </el-submenu> -->
                
            </el-menu>
        </el-aside>
        
        <el-container>
            <el-header style="text-align: right; font-size: 12px">
            <el-dropdown>
                <span class="username">{{username}}</span>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item @click.native="logout">退出</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
            
            </el-header>
            
            <el-main>
                <router-view></router-view>
            </el-main>
        </el-container>
        </el-container>
    </div>
</template>

<script>

    import { menuRouts } from '../router/index'
    import {logout} from '../api/user'
    import path from 'path'

    export default {
        name: "index",
        computed: { // 计算属性
            routePath() {
                // 获取当前页面的 path
                return this.$route.path
            }
        },
        data() {
            return {
                menuRouts: menuRouts,
                username: ''
            }
        },
        created() {   
            // console.log("route_path: ", this.$route.path)
            // console.log("routePath: ", this.routePath);
            // console.log("menuRouts: ", this.menuRouts)
            // console.log("path: ", path)
        },
        mounted(){
            this.username = this.$store.state.user
            console.log(this.username)
        },
        methods: {
            resolvePath(base, p) {
                return path.resolve(base, p)
            },
            resolvePath2(base, middle, p) {
                return path.resolve(base, middle, p)
            },
            routeName(route) {
                return route.meta ? route.meta.title : route.name
            },
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

<style lang="scss" scoped>
  .el-header {
    background-color: #B3C0D1;
    color: #333;
    line-height: 60px;
  }
  
  .el-aside {
    color: #333;
  }

  .username:hover{
    cursor: pointer;
  }
</style>

