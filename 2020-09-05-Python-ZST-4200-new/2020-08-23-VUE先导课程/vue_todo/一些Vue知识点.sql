
v-model 指令：
	Vue 还提供了 v-model 指令，它能轻松实现表单输入和应用状态之间的双向绑定。 
	by https://cn.vuejs.org/v2/guide/index.html#Vue-js-%E6%98%AF%E4%BB%80%E4%B9%88


表单输入绑定：
	https://cn.vuejs.org/v2/guide/forms.html
	
	
选项 / 生命周期钩子

	created() 函数
	
	类型：Function

	详细：

		在实例创建完成后被立即调用。
		在这一步，实例已完成以下的配置：数据观测 (data observer)，property 和方法的运算，watch/event 事件回调。
		然而，挂载阶段还没开始，$el property 目前尚不可用。
		
		
	mounted() 函数
	
	类型：Function

	详细：

		实例被挂载后调用，这时 el 被新创建的 vm.$el 替换了。如果根实例挂载到了一个文档内的元素上，当 mounted 被调用时 vm.$el 也在文档内。
		
methods 属性
	
	在 `methods` 对象中定义方法
	
	总结
		1.使用methods属性给vue定义方法

		2.在方法中使用this.属性名就可以直接访问data中的数据

		3.在构造函数外部可以使用vm.方法名定义或者调用方法