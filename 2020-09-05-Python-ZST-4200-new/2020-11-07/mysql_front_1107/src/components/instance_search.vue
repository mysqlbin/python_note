<template>
  
    <el-autocomplete
            class="inline-input"
            v-model="instance"
            :placeholder="placeholder" 
            :fetch-suggestions="querySearch"
            style="width:300px"
    ></el-autocomplete>
    
</template>

<script>

    import {getInstanceNameList} from '../api/schema_info'

    export default {
        name: "index",
        components: {},
        props: {
            value: {
                type: String,
                required: true
            },
            placeholder: {
                type: String,
                default: '请输入实例名称'
            }
        
        },
        data() {
            return {
                instance: "",
                instanceNameList: [],

            }
        },
        created() {
            this.instance = this.value
            getInstanceNameList().then(resp => {
                this.instanceNameList = resp.data
            })
        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           instance(newVal, oldVal) {
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