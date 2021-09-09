console.log('javascript study')



// ...... 异步 ......

// ...... setTimeout ......
// 箭头函数 setTimeout 有两个参数, 第一个参数是function, 第二个参数是延迟时间
// 简单的异步例子
// setTimeout(() => console.log('i am time out'),1000)
// console.log('i am a console log')

/*
setTimeout(function(){
	console.log('i am a timeout function')
}, 2000)
console.log('i am a console log')

改写为箭头函数
setTimeout(() => console.log('i am time out'), 1000)
*/


// ...... Ajax ......

// function reqListener(){ 
//     console.log(this.responseText);
// }
// var oReq = new XMLHttpRequest();
// oReq.addEventListener("load", reqListener);   // callback, 回调函数
// oReq.open("GET", 
// "http://localhost:9090/index.html");
// oReq.send();
// console.log('after oReq.send')


// https://www.cnblogs.com/wenxuehai/p/10455664.html              JavaScript中的回调地狱及解决方法
// https://www.runoob.com/w3cnote/javascript-promise-object.html  JavaScript Promise 对象
// https://blog.csdn.net/hyupeng1006/article/details/80351174     ES6---new Promise()讲解




// ...... 创建 promise 的步骤 ......

// var promise = new Promise(function(resolve, reject) {
//     // 异步处理
//     // 处理结束后、调用resolve 或 reject
// });

/*
// 创建Promise
var myFirstPromise = new Promise(function(resolve, reject){
     //当异步代码执行成功时，我们才会调用 resolve(...), 当异步代码失败时就会调用 reject(...)
     //在本例中，我们使用setTimeout(...)来模拟异步代码，实际编码时可能是XHR请求或是HTML5的一些API方法.
	 // setTimeout(JavaScript 函数, 等待的毫秒数)
     setTimeout(function(){
         resolve("成功!"); //代码正常执行！
     }, 3000);
});
*/


/*
// 调用Promise
myFirstPromise.then(function(successMessage){
     //successMessage的值是上面调用resolve(...)方法传入的值.
     //successMessage参数不一定非要是字符串类型，这里只是举个例子
     console.log("Yay! " + successMessage);
});
*/

// 返回值： Yay! 成功!
 
// 对于已经实例化过的 promise 对象可以调用 promise.then() 方法，传递 resolve 和 reject 方法作为回调。



// ...... 回调地狱 ......
// setTimeout(function(){
//     console.log("I am first")
//     setTimeout(function(){
//         console.log("I am second")
//         setTimeout(function(){
//             console.log("I am third")
//         }, 1000)
//     },1000)
// },1000)

/*
// wait 是一个 function, 它的参数 ms
let wait = (ms) => new Promise(
        // 异步处理， (resolve) 的含义：等价于 function(resolve) {} 
    (resolve) => setTimeout(resolve, ms)
)
*/

// 通过链式调用，改写回调地狱的写法 
// 这里箭头函数的写法跟上面的等价
let wait = (ms) => new Promise(function(resolve){
	setTimeout(resolve, ms)
})

wait(3000)
     // 3秒后先执行这里
     .then(() => {
		 console.log("i am first");  
		 // 返回1个Promose，才能继续进行下面的链式调用
		 // 调用 wait() 函数，等价于 1个Promise对象
		 return wait(9000)
	 })
     // 12秒后再执行这里
     .then(() => {
		 console.log("i am second"); 
		 // 返回1个Promose，才能继续进行下面的链式调用
		 return wait(5000)
	 })
	 // 17秒后执行这里
     .then(
		() => console.log("i am third")
	)



// -------------------------------------------


// 下面的内容是网上的讲解
/*
var p = new Promise(function(resolve, reject){
    //做一些异步操作
    setTimeout(function(){
        console.log('执行完成');
        resolve('随便什么数据');
    }, 2000);
});
*/


function runAsync(ms){
    var p = new Promise(function(resolve, reject){
        //做一些异步操作
        setTimeout(function(){
            console.log('执行完成');
            resolve('随便什么数据');
        }, ms);
    });
    return p;            
}


// runAsync().then(function(data){
//     console.log(data);
//     //后面可以用传过来的数据做些其他操作
//     //......
// });


// 在runAsync()的返回上直接调用then方法，then接收一个参数，是函数，并且会拿到我们在runAsync中调用resolve时传的的参数
// 而Promise的优势在于，可以在then方法中继续写Promise对象并返回，然后继续调用then来进行回调操作。


runAsync(2000)
.then(function(data){
    console.log(data);
    return runAsync(5000);
})
.then(function(data){
    console.log(data);
    return runAsync(3000);
})
.then(function(data){
    console.log(data);
});

// -------------------------------------------
// ...... 分析一个Promise对象的案例 ......

let newPromise = Promise.resolve('foo')
newPromise.then(Promise.resolve('bar'))   // 这一步不会输出, 原因：then()是Promise对象中的方法，对于已经实例化过的Promise对象可以调用 then() 方法，传递 resolve 和 reject 方法作为回调。这里只是实例了1个Promise对象，并没有调用then()方法，传递resolve()方法作为回调。

// then 是 newPromise对象的方法
.then(function(result_data) {       
    // result_data 的值是上面调用resolve(...)方法传入的值.
    // result_data 参数不一定非要是字符串类型，这里只是举个例子
    console.log(result_data);
    console.log(newPromise);
});




// 默认是pending状态
// 调用resolve后，变成fulfilled状态，调用then函数
// 调用reject函数后，变成Rejected状 态

// pending   待定
// resolve   解决
    // fulfilled 实现
// rejected  拒绝


// 相关参考
// https://www.cnblogs.com/wenxuehai/p/10455664.html              JavaScript中的回调地狱及解决方法
// https://www.runoob.com/w3cnote/javascript-promise-object.html  JavaScript Promise 对象
// https://blog.csdn.net/hyupeng1006/article/details/80351174     ES6---new Promise()讲解
	// 用Promise的时候一般是包在一个函数中，在需要的时候去运行这个函数，
	
	
/*

1. resolve的作用：用于 .then()方法中的函数回调
2. 对于已经实例化过的 promise 对象可以调用 promise.then() 方法，传递 resolve 和 reject 方法作为回调。
3. Promise对象的链式调用，从回调地狱中解放出来
4. 每一次看Promise，去理解，都有收获。

*/


