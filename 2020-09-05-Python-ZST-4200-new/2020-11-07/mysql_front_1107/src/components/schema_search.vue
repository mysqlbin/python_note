<template>
  
    <el-autocomplete
            class="inline-input"
            v-model="schema"
            :fetch-suggestions="querySearch"
            placeholder="请输入库名"
    ></el-autocomplete>
    
</template>

<script>

    import {getSchemaNameList} from '../api/schema_info'

    export default {
        name: "index",
        components: {},
        data() {
            return {
                schema: "",
                schemaNameList: [],

            }
        },
        created() {
            getSchemaNameList().then(resp => {
                // console.log(111111)
                // if(resp.code === 2000) {
                this.schemaNameList = resp.data
                // console.log("schemaNameList:", this.schemaNameList)
                // }
            })
        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           schema(newVal, oldVal) {
				// console.log("newVal: ", newVal)
                // console.log("oldVal: ", oldVal)
                this.$emit('input', newVal)   // 子组件向父组件传递数据, 初步理解了，不这样传递数据，在子组件修改数据，父组件的值不会改变
                
            }
        },
        methods: {
            
            querySearch(queryString, cb) {
                let schemaNameList = this.schemaNameList
                let results = schemaNameList.filter(s => {
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