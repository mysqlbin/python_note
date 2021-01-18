<template>
  
    <el-autocomplete
            class="inline-input"
            v-model="instance"
            :fetch-suggestions="querySearch"
            placeholder="请输入实例名称"
            style="width:300px"
    ></el-autocomplete>
    
</template>

<script>

    import {getInstanceNameList} from '../api/schema_info'

    export default {
        name: "index",
        components: {},
        data() {
            return {
                instance: "",
                instanceNameList: [],

            }
        },
        created() {
            getInstanceNameList().then(resp => {
                // console.log(111111)
                // if(resp.code === 2000) {
                this.instanceNameList = resp.data
                // console.log("schemaNameList:", this.schemaNameList)
                // }
            })
        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           instance(newVal, oldVal) {
				// console.log("newVal: ", newVal)
                // console.log("oldVal: ", oldVal)
                this.$emit('input', newVal)   // 子组件向父组件传递数据, 初步理解了，不这样传递数据，在子组件修改数据，父组件的值不会改变
                
            }
        },
        methods: {
            
            querySearch(queryString, cb) {
                let instanceNameList = this.instanceNameList
                let results = instanceNameList.filter(s => {
                    return queryString ? s.toLocaleLowerCase().indexOf(queryString.toLowerCase()) > -1 : true
                }).map(s => {
                    return {value: s}
                })
                // console.log(results)
                cb(results)
            },

           
        },

    }
</script>

<style lang="scss" scoped>
    .demo-form-inline {
        float: left;
    }
</style>