

问题
	λ npm install webpack -g --registry=https://registry.npm.taobao.org

	Could not install from "registry=https:\registry.npm.taobao.org" as it does not contain a package.json file.
	 
	 
	debug.log
		0 info it worked if it ends with ok
		1 verbose cli [
		1 verbose cli   'D:\\anzhuang\\nodejs\\node.exe',
		1 verbose cli   'C:\\Users\\Administrator\\AppData\\Roaming\\npm\\node_modules\\npm\\bin\\npm-cli.js',
		1 verbose cli   'install',
		1 verbose cli   'webpack',
		1 verbose cli   '-g',
		1 verbose cli   '--',
		1 verbose cli   'registry=https://registry.npm.taobao.org'
		1 verbose cli ]
		2 info using npm@6.14.8
		3 info using node@v12.18.3
		4 verbose npm-session e03f91018095cd52
		5 silly install loadCurrentTree
		6 silly install readGlobalPackageData
		7 silly fetchPackageMetaData error for file:registry=https:\registry.npm.taobao.org Could not install from "registry=https:\registry.npm.taobao.org" as it does not contain a package.json file.
		8 http fetch GET 304 https://registry.npmjs.org/webpack 910ms (from cache)
		9 silly pacote tag manifest for webpack@latest fetched in 983ms
		10 timing stage:rollbackFailedOptional Completed in 0ms
		11 timing stage:runTopLevelLifecycles Completed in 1012ms
		12 verbose stack Error: ENOENT: no such file or directory, open 'C:\Users\Administrator\Desktop\registry=https:\registry.npm.taobao.org\package.json'
		13 verbose cwd C:\Users\Administrator\Desktop
		14 verbose Windows_NT 6.1.7601
		15 verbose argv "D:\\anzhuang\\nodejs\\node.exe" "C:\\Users\\Administrator\\AppData\\Roaming\\npm\\node_modules\\npm\\bin\\npm-cli.js" "install" "webpack" "-g" "--" "registry=https://registry.npm.taobao.org"
		16 verbose node v12.18.3
		17 verbose npm  v6.14.8
		18 error code ENOLOCAL
		19 error Could not install from "registry=https:\registry.npm.taobao.org" as it does not contain a package.json file.
		20 verbose exit [ 1, true ]


解决办法
	npm config set registry https://registry.npm.taobao.org
	npm info underscore
	

C:\Users\Administrator\Desktop
λ npm install webpack -g --registry=https://registry.npm.taobao.org
npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
npm WARN deprecated chokidar@2.1.8: Chokidar 2 will break on node v14+. Upgrade to chokidar 3 with 15x less dependencies.
npm WARN deprecated fsevents@1.2.13: fsevents 1 will break on node v14+ and could be using insecure binaries. Upgrade to fsevents 2.
C:\Users\Administrator\AppData\Roaming\npm\webpack -> C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\bin\webpack.js
npm WARN notsup Unsupported engine for watchpack-chokidar2@2.0.0: wanted: {"node":"<8.10.0"} (current: {"node":"12.18.3","npm":"6.14.8"})
npm WARN notsup Not compatible with your version of node/npm: watchpack-chokidar2@2.0.0
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.13 (node_modules\webpack\node_modules\watchpack-chokidar2\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.13: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.1.3 (node_modules\webpack\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.3: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})


C:\Users\Administrator\Desktop
λ npm install webpack-cli -g --registry=https://registry.npm.taobao.org
npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
C:\Users\Administrator\AppData\Roaming\npm\webpack-cli -> C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack-cli\bin\cli.js
npm WARN webpack-cli@3.3.12 requires a peer of webpack@4.x.x but none is installed. You must install peer dependencies yourself.

+ webpack-cli@3.3.12
added 185 packages from 127 contributors in 11.499s

