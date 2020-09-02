<template>
    <div>
        <p>
            <slot></slot>
            {{textcontent}} 
            <button @click="dels">删除</button>
            <button @click="ups">编辑</button>
        </p> 
        <p>
            <slot name="content"></slot> 
        </p> 
    </div>
</template>

<script>
export default {
    // 组件的名称
    name: "TodoItem",
    // 通过 Prop 向子组件传递数据
    // 传递数据，从父组件传递进来的值
    // "prop"，类似于一个自定义 attribute。
    // 这个 prop 名为 TodoItem。
    props: { 
        "textcontent": {
            default: 'no content',
            type: String,
        },
        "color": {
            default: 'red',
            type: String,
        }
    },
    methods: {
        dels() {
            this.$emit('delItem') // 触发当前实例上的delItem事件
        },
        ups() {
            this.$emit('updateItem') // 触发当前实例上的updateItem事件
        }
    },
}
</script>