console.log('javascript study')

// if (true){
//    var abc = 1;
//    console.log(abc) 
// }
// console.log(abc)

// 1
// 1

// if (true){
//     let efg = 2;
//     console.log(efg) 
//  }
//  console.log(efg)


// 2
// main.js:14 Uncaught ReferenceError: efg is not defined
//     at main.js:14


// const abc = "123"
// console.log(abc)
// abc = "456"

// 123
// Uncaught TypeError: Assignment to constant variable.


// const abc = [1, 2, 3]
// console.log(abc)
// abc.push(4)
// console.log(abc)

// (3) [1, 2, 3]
// (4) [1, 2, 3, 4]


// const abc = [1, 2, 3]
// console.log(abc);
// abc = [4, 5, 6]
// console.log(abc)

// (3) [1, 2, 3]
// Uncaught TypeError: Assignment to constant variable.


// var abc;
// console.log(abc)

// undefined


// 获取函数的名字

// function sums (){
//     console.log('sums')
// }

// console.log(sums.name)   


// 对象表达式
// 标识符号作为属性名
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


// 对象表达式 es6 里面的语法
// let addr = 'abc';
// let num = 1;
// var obj = {
//     addr,
//     num
// }
// console.log(obj)

// {addr: "abc", num: 1}


// 普通函数
// function abcd(p1, p2){
//     console.log(p1, p2)
// }

// abcd(1, 2, 3)

// 1 2


// 匿名函数
// let f = function(){

// }

// 箭头函数
// let sum = (a, b) => a + b;
// console.log(sum(1, 2))
// 3


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


// 展开操作符

// let arr = ['a', 'b', 'c']
// console.log(...arr)
// console.log('a', 'b', 'c')
// console.log(arr)

// let newArr = ['1', '2', ...arr] 
// console.log(newArr)

// // 二维数组
// console.log(['1', '2', arr]) 


// 箭头函数
// let sum = (a, b) => a + b;
// console.log(sum(1, 2))
// 3

// let print = () => {
//     console.log('hello world')
// }


// setTimeout有两个参数, 第一个参数是function, 第二个参数是延迟时间
// setTimeout(() => console.log('i am time out'),
//     1000
// )
// console.log('i am a console log')

// setTimeout(function(){
//     console.log('i am a timeout function')
// }, 2000)
// console.log('i am a console log')


// Ajax
// function reqListener(){ 
//     console.log(this.responseText);
// }
// var oReq = new XMLHttpRequest();
// oReq.addEventListener("load", reqListener);   // callback, 回调函数
// oReq.open("GET", 
// "http://localhost:9090/index.html");
// oReq.send();
// console.log('after oReq.send')

// setTimeout(function(){
//     console.log("I am first")
//     setTimeout(function(){
//         console.log("I am second")
//         setTimeout(function(){
//             console.log("I am third")
//         }, 1000)
//     },1000)
// },1000)



// wait 是一个 function, 它的参数 ms
// let wait = (ms) => new Promise(
//     (resolve) => setTimeout(resolve, ms)
// )
// // // 链式调用 
// wait(5000)
//     // 先执行这里
//     .then(() => {console.log("i am first");  return wait(2000)})
//     // 再执行这里
//     .then(() => {console.log("i am second"); return wait(1000)})
//     // 最后执行这里
//     .then(() => console.log("i am third"))

 
// 这里是拆分上面的步骤
// wait 是一个 function, 它的参数 ms

// let wait = function(ms){
//     return new Promise(function(resolve, reject){
//         setTimeout(resolve, ms)
//     })
// }

// wait(5000).then(function(){
//     console.log("i am first")
//     return wait(2000)
// }).then(function(){
//     console.log("i am second")
//     return wait(1000)
// }).then(function(){
//     console.log("i am third")
// })

// then() 方法是 Promise对象的方法


Promise.resolve('foo')
.then(Promise.resolve('bar'))   // 这一步不会输出
.then(function (result) {       // result 是function一个参数
    console.log(result);
});


// 默认是pending状态
// 调用resolve后，变成fulfilled状态，调用then函数
// 调用reject函数后，变成Rejected状 态

// pending   待定
// resolve   解决
    // fulfilled 实现
// rejected  拒绝




