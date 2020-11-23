<template>
    <div>
        {{routePath}}
        <el-container style="height: 500px; border: 1px solid #eee">
        <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
            <el-menu :default-active="routePath" :default-openeds="['1', '3']">
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
                                    <!-- {{routeName(child)}} -->
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
                


            <!-- <el-submenu index="1">
                <template slot="title"><i class="el-icon-message"></i>导航一</template>
                <el-menu-item-group>
                <template slot="title">分组一</template>
                <el-menu-item index="1-1">选项1</el-menu-item>
                <el-menu-item index="1-2">选项2</el-menu-item>
                </el-menu-item-group>
                <el-menu-item-group title="分组2">
                <el-menu-item index="1-3">选项3</el-menu-item>
                </el-menu-item-group>
                <el-submenu index="1-4">
                <template slot="title">选项4</template>
                <el-menu-item index="1-4-1">选项4-1</el-menu-item>
                </el-submenu>
            </el-submenu>
            <el-submenu index="2">
                <template slot="title"><i class="el-icon-menu"></i>导航二</template>
                <el-menu-item-group>
                <template slot="title">分组一</template>
                <el-menu-item index="2-1">选项1</el-menu-item>
                <el-menu-item index="2-2">选项2</el-menu-item>
                </el-menu-item-group>
                <el-menu-item-group title="分组2">
                <el-menu-item index="2-3">选项3</el-menu-item>
                </el-menu-item-group>
                <el-submenu index="2-4">
                <template slot="title">选项4</template>
                <el-menu-item index="2-4-1">选项4-1</el-menu-item>
                </el-submenu>
            </el-submenu>
         -->


            </el-menu>
        </el-aside>
        
        <el-container>
            <el-header style="text-align: right; font-size: 12px">
            <el-dropdown>
                <i class="el-icon-setting" style="margin-right: 15px"></i>
                <el-dropdown-menu slot="dropdown">
                <el-dropdown-item>查看</el-dropdown-item>
                <el-dropdown-item>新增</el-dropdown-item>
                <el-dropdown-item>删除</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
            <span>王小虎</span>
            </el-header>
            
            <el-main>
            <!-- <el-table :data="tableData">
                <el-table-column prop="date" label="日期" width="140">
                </el-table-column>
                <el-table-column prop="name" label="姓名" width="120">
                </el-table-column>
                <el-table-column prop="address" label="地址">
                </el-table-column>
            </el-table> -->
                <router-view></router-view>
            </el-main>
        </el-container>
        </el-container>
    </div>
</template>

<script>

    import { menuRouts } from '../router/index'
    import path from 'path'

    export default {
        name: "index",
        computed: { // 计算属性
            routePath() {
                return this.$route.path
            }  
        },
        data() {
            return {
                menuRouts: menuRouts
            }
        },
        created() {
            console.log("routePath: ", this.routePath);
            console.log("menuRouts: ", this.menuRouts)
        },
        methods: {
            resolvePath(base, p) {
                return path.resolve(base, p)
            },
            routeName(route) {
                return route.meta ? route.meta.title : route.name
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
</style>

