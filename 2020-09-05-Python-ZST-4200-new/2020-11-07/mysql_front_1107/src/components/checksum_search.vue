<template>
    
    <el-input :placeholder="placeholder" v-model="sqlid" style="width:250px" clearable></el-input>

</template>

<script>

    export default {
        name: "checksum_search",
        components: {},
        props: {
            value: {
                type: String,
                required: true
            },
            placeholder: {
                type: String,
                default: '请输入SQLId'
            }
        
        },
        data() {
            return {
                sqlid: "",
            }
        },
        created() {
            
            this.sqlid = this.value
           
        },
        // 侦听事件，不加这个，点击上一页、下一页不生效
        watch: {
           sqlid(newVal, oldVal) {
                console.log("value:", this.value)
                if (newVal !== this.value) {
                    this.$emit('input', newVal)   // 子组件向父组件传递数据, 初步理解了，不这样传递数据，在子组件修改数据，父组件的值不会改变
                }  
            }
        
        },
        methods: {
            
        },

    }
</script>

<style lang="scss" scoped>
    .demo-form-inline {
        float: left;
    }
</style>