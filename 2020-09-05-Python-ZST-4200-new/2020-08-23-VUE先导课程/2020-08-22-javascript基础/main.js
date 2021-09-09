console.log('javascript study')

// ...... var .......
// if (true){
//    var abc = 1;
//    console.log(abc) 
// }
// console.log(abc)

// 1
// 1


// ...... let ，es6的语法 .......
// if (true){
//     let efg = 2;
//     console.log(efg) 
//  }
//  console.log(efg)

// 2
// main.js:14 Uncaught ReferenceError: efg is not defined
//     at main.js:14


// ...... const .......
// const abc = "123"
// console.log(abc)
// abc = "456"

// 123
// Uncaught TypeError: Assignment to constant variable.

// const 常量的修改方式
// const abc = [1, 2, 3]
// console.log(abc)
// abc.push(4)
// console.log(abc)

// (3) [1, 2, 3]
// (4) [1, 2, 3, 4]

// const常量的赋值修改
// const abc = [1, 2, 3]
// console.log(abc);
// abc = [4, 5, 6]
// console.log(abc)

// (3) [1, 2, 3]
// Uncaught TypeError: Assignment to constant variable.


// ...... undefined .......
// Undefined 如果声明了一个变量，但没有任何赋值，那么这个变量就是Undefined；
// var abc;
// console.log(abc)

// undefined


// 获取函数的名字

// function sums (){
//     console.log('sums')
// }

// console.log(sums.name)  

 
// ...... 对象 ......

// 标识符号作为属性名，标识符号没有空格
// 声明1个空对象
// var obj = {}
// obj.addr = '1st'
// console.log(typeof(obj))
// console.log(obj)

// object
// {addr: "1st"}

// 标识符号(有空格)作为属性名
// var obj = {}
// obj['home addr'] = '1st'
// console.log(obj)
// {home addr: "1st"}


// ...... 对象表达式 ......
// 对象表达式 es6 里面的语法，变量名作为属性名
// let addr = 'abc';
// let num = 1;
// var obj = {
//     addr,
//     num
// }
// console.log(obj)
// 可以看下在项目中哪里用到了
// {addr: "abc", num: 1}



// ...... 函数 ......
// 普通函数
// function functionName(parameter1, parameter2){}
// function abcd(p1, p2){
//     console.log(p1, p2)
// }

// abcd(1, 2, 3)

// 1 2


// 匿名函数
// let f = function(){
	
// }

// 箭头函数
// 箭头函数的优势：代码简洁
// 相关参考：https://www.cnblogs.com/fundebug/p/6904753.html
// let functionName = (parameter1, parameter2) => {表达式} ;

// 返回值只能一个表达式，可以省略大括号
// let sum = (a, b) => a + b;
// console.log(sum(1, 2))
// 3

// 如果没有参数，还可以进一步简化
// let print = () => {
//     console.log('hello world')
// }
// print()
// hello world

// let print = (p1, p2) => {
//     console.log(p1, p2)
// }
// print(1, 2)
// 1 2


// ...... 数组 ......
// let arr = []
// arr[0] = 1
// arr[1] = '2'

// 添加元素
// arr.push('3')
// console.log(arr)
// arr[40] = '41'
// console.log(arr)
//  [1, "2", "3", empty × 37, "41"]

// delete 删除元素
// let arr = []
// arr[0] = 1
// arr[1] = '2'
// arr.push('3')
// arr[40] = '41'
// // arr.push('42')
// console.log(arr)
// //   (41) [1, "2", "3", empty × 37, "41"]
// delete arr[40]
// console.log(arr)
// //   (41) [1, "2", "3", empty × 38]
// console.log(arr[40])

// splice删除
// let arr = []
// arr[0] = 1
// arr[1] = '2'
// arr.push('3')
// arr[40] = '41'
// console.log(arr[40])
// console.log('before splice', arr)
// arr.splice(40, 1)
// console.log('after splice', arr)
// console.log(arr[40])

// before splice (41) [1, "2", "3", empty × 37, "41"]
// after splice (40) [1, "2", "3", empty × 37]


let arr = []
arr[0] = 1
arr[1] = '2'
arr.push('3')
arr.splice(1, 1)
console.log("arr:", arr)

// 二维数组
// arr = []
// arr.push(['bin', 28])
// arr.push(['neo', 30])
// console.log(arr)

/*
arr = [
 ['bin', 28],
 ['neo', 30],
]
*/

/*
项目中的应用
let chartData = [];
// 组装数据，渲染到图表中
	_.forEach(resp.data.data, (v) => {
	chartData.push([moment(v["byday"].concat(" 08:00:00")).unix() * 1000, v["date_count"]]);
});
*/			
				

/*
https://www.cnblogs.com/jhuang-com/p/10476365.html  js数组删除（splice和delete）
最近一直在写js的数组，然后就发现了很奇怪的问题，后来才发现了规律。

删除数据的一行，一般有两种方法，一个是splice，一个是delete；

splice：删除了数组后，数组的长度会自动变化。用法：arr.splice(2,1)——2是数组的下标值，1 代表输出一行数据。

delete: 删除了数组后，数组的长度不会变化。 用法：delete arr[2] ——2是数组的下标值

// 理解了,最重要的是理解
*/


// 数组解析和对象解析
// 数组的解析
// let arr = ['a', 'b', 'c']
// var a,b,c;
// a = arr[0]
// b = arr[1]
// c = arr[2]
// console.log(a, b, c)


// let arr = ['a', 'b', 'c']
// let [a, b, c] = arr
// console.log(a, b, c)

// 对象的解析

// let obj = {
//     a: '1',
//     b: '2',
//     c: '3'
// }

// var a, b, c;
// a = obj.a;
// b = obj.b;
// c = obj.c;
// console.log(a, b, c)
// 1 2 3

// ----------------------------

// let obj = {
//     a: '1',
//     b: '2',
//     c: '3'
// }
// let { a: a1, b: b1, c: c1 } = obj;
// console.log(a1, b1, c1)

// let {a, b, c} = obj;
// console.log(a, b, c)


// ...... 展开操作符 ......
// let arr = ['a', 'b', 'c']  
// console.log(...arr) // 等价于 console.log('a', 'b', 'c')
// console.log(arr)

// let newArr = ['1', '2', ...arr] 
// console.log(newArr)

// // // 二维数组
// console.log(['1', '2', arr]) 



// let redirect = '/mysql';
// console.log(typeof(redirect))
// redirect = typeof(redirect) == "number" ? redirect : undefined;
// console.log(redirect);
// console.log("decodeURI(redirect): ", decodeURI(redirect));
// redirect = redirect ? decodeURI(redirect) : "/";  // 如果 redirect 为 undefined，就取 "/" ？ 是的。
// console.log(redirect);


// a = undefined

// if (a)
// 	console.log(1)

// 如果值等于undefined，那么不为真


var data = {};
data.name = "hello";
 
let {name} = data;
console.log(name); // hello