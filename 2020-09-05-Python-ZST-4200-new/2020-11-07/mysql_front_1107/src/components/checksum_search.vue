<template>
    
    <el-input placeholder="请输入SQLId" v-model="sqlid" style="width:250px" clearable></el-input>

</template>

<script>

    export default {
        name: "index",
        components: {},
        props: {
            value: {
                type: String,
                required: true
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
				// console.log("newVal: ", newVal)
                // console.log("oldVal: ", oldVal)
                this.$emit('input', newVal)   // 子组件向父组件传递数据, 初步理解了，不这样传递数据，在子组件修改数据，父组件的值不会改变
                
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