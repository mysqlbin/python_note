<template>
    <div class="sidebar-container">
        <el-scrollbar wrap-class="scrollbar-wrapper">
            <el-menu :default-active="routePath" class="el-menu-vertical-demo" background-color="rgb(48, 65, 86)" text-color="#fff" active-text-color="red" router>

                 <div v-for="(submenu, key) in menuRouts" :key="key">
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
                                <el-menu-item v-for="(child, cKey) in submenu.children" :key="cKey" :index="resolvePath(submenu.path, child.path)">
                                    {{routeName(child)}}
                                </el-menu-item>
                            </el-menu-item-group>

                        </el-submenu>
                    </template>

                </div>

            </el-menu>
        </el-scrollbar>
        
    </div>
</template>

<script>
    import { menuRouts } from '@/router/index'
    import path from 'path'
    export default {
        name: "index",
        data() {
            return {
                menuRouts: menuRouts,
                activeIndex: "/Home"
            }
        },
        watch: {
            $route() {
                // console.log(1)
            }
        },
        created(){

            // console.log("route_path: ", this.$route.path)
            // console.log("routePath: ", this.routePath);
            // console.log("menuRouts: ", this.menuRouts)
            // console.log("path: ", path)
        },
        computed: {
             routePath() {
                // 获取当前页面的 path
                return this.$route.path;
            },
        },
        methods: {
            resolvePath(base, p) {
                return path.resolve(base, p)
            },
            routeName(route) {
                return route.meta ? route.meta.title : route.name
            },
            
        }   
    }
</script>

<style>

    .sidebar-container {
        width: 200px;
        position: fixed;
        left: 0;
        height: 100%;
        overflow: hidden;
    }

    .scrollbar-wrapper {
        height: 100%;
        overflow-x: hidden !important;
    }

    .scrollbar-wrapper {
        height: 100%;
        overflow-x: hidden !important;
        background-color: rgb(48, 65, 86);
    }

    .sidebar-container .el-scrollbar {
        height: 100%;
    }

    .sidebar-container .el-scrollbar a{
        text-decoration:none;
        color: rgb(255, 255, 255);
    }


</style>
