

npm install yarn -g --registry=https://registry.npm.taobao.org 
npm install -g @vue/cli --registry=https://registry.npm.taobao.org 
vue create mysql_front_1107



E:\github\python_note\2020-09-05-Python-ZST-4200-new\2020-11-07\mysql_front_1107 (master -> origin)        
λ yarn serve                                                                                               
yarn run v1.22.4                                                                                           
$ vue-cli-service serve                                                                                    
'vue-cli-service' 不是内部或外部命令，也不是可运行的程序                                                                      
或批处理文件。                                                                                                    
error Command failed with exit code 1.                                                                     
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.                       

	
	npm install yarn -g --registry=https://registry.npm.taobao.org 
	npm install -g @vue/cli --registry=https://registry.npm.taobao.org 
	
	
	E:\github\python_note\2020-09-05-Python-ZST-4200-new\2020-11-07\mysql_front_1107 (master -> origin)
	λ yarn serve
	yarn run v1.22.10
	$ vue-cli-service serve
	'vue-cli-service' 不是内部或外部命令，也不是可运行的程序
	或批处理文件。
	error Command failed with exit code 1.
	info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
	
	
	执行 npm install
		-- 会生成  node_modules 文件 
	E:\github\python_note\2020-09-05-Python-ZST-4200-new\2020-11-07\mysql_front_1107 (master -> origin)
	λ yarn serve
	yarn run v1.22.10
	$ vue-cli-service serve
	 INFO  Starting development server...

Vue的生命周期
	created() 和 mounted()：
		先执行完成 created()中的内容，再执行 mounted() 中的内容；
		类似于操作系统和磁盘，操作系统先启动，再挂载磁盘。
		应用场景之一：图表库ECharts，先在 created() 加载完成Dom后，然后在 mounted()中绑定Dom元素，引入图表库ECharts。
		
		先 created(), 等加载完成Dom后，然后在 mounted()中绑定Dom元素。
		
			先加载 html(Dom)、再加载 图表。
			如果不加载完html(Dom)，可能就会找不到要绑定的元素。
	
	在created中调用echarts的画图会报以下的错误。这是因为dom节点还不存在，所以echarts无法获取	
		[Vue warn]: Error in created hook: "TypeError: Cannot read property 'getAttribute' of null"

		found in

		---> <Login> at src/views/Login.vue
			   <App> at src/App.vue
				 <Root>
			 
		 
npm install echarts --registry=https://registry.npm.taobao.org		

yarn add axios

修改 vue.config.js 之后，要重启

// 1. 如果有多个axios请求，没有必要为每个请求都写 axios.post(), 因此可以独立出来在 api 目录的文件中 
	
	Login.vue
	
		before
			Login.vue
			import Axios from "axios"	
			Axios.post('/user/api/django_ldap_login/', this.login).then(resp => {
		
		after 
			auth.js
				import Axios from "axios"

				export let login = (data) => {
					return Axios.post("/user/api/django_ldap_login/", data)
				}
				
			Login.vue
				import {login} from '../api/auth'
				login(this.login).then(resp => {

		
		
		
// 2. 同一个APP的每个axios请求的URL前缀都是一样，因此URL前缀又可以独立出来在 util 目录的文件中 

	before
		auth.js
			import Axios from "axios"

			export let login = (data) => {
				return Axios.post("/user/api/django_ldap_login/", data)
			}
	after 
		auth.js
			
			import request from '../util/requests'
			
			export let login = (data) => {
				return request.post('/auth/login/', data)
			}
			
		request.js 
		
			import axios from 'axios'

			const request = axios.create({
				baseURL: '/api/zst_mysql/v1/',
				timeout: 10000
			})

			export default request
				
	
	
	
	
	
yarn add lodash

	
	
	