console.log('javascript study')



// ...... 异步 ......

// ...... setTimeout ......
// 箭头函数 setTimeout 有两个参数, 第一个参数是function, 第二个参数是延迟时间
// setTimeout(() => console.log('i am time out'),1000)
// console.log('i am a console log')

/*
setTimeout(function(){
	console.log('i am a timeout function')
}, 2000)
console.log('i am a console log')

setTimeout(() => console.log('i am time out'), 1000)
*/


// 创建 promise 的步骤：

// var promise = new Promise(function(resolve, reject) {
//     // 异步处理
//     // 处理结束后、调用resolve 或 reject
// });

/*
var myFirstPromise = new Promise(function(resolve, reject){
     //当异步代码执行成功时，我们才会调用resolve(...), 当异步代码失败时就会调用reject(...)
     //在本例中，我们使用setTimeout(...)来模拟异步代码，实际编码时可能是XHR请求或是HTML5的一些API方法.
     setTimeout(function(){
         resolve("成功!"); //代码正常执行！
     }, 3000);
});
*/


/*
myFirstPromise.then(function(successMessage){
     //successMessage的值是上面调用resolve(...)方法传入的值.
     //successMessage参数不一定非要是字符串类型，这里只是举个例子
     console.log("Yay! " + successMessage);
});
*/

// Yay! 成功!
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

// wait 是一个 function, 它的参数 ms
/*
let wait = (ms) => new Promise(
        // 异步处理， (resolve) 的含义：等价于 function(resolve) {} 
    (resolve) => setTimeout(resolve, ms)
)
*/

// 跟上面的等价的

/*
let wait = (ms) => new Promise(function(resolve){
	
	setTimeout(resolve, ms)
	
})

// 链式调用 
wait(3000)
     // 先执行这里
     .then(() => {
		 console.log("i am first");  
		 return wait(2000)
	 })
     // 再执行这里
     .then(() => {
		 console.log("i am second"); 
		 return wait(1000)
	 })
	 // 最后执行
     .then(
		() => console.log("i am third")
	)
*/



/*
var p = new Promise(function(resolve, reject){
    //做一些异步操作
    setTimeout(function(){
        console.log('执行完成');
        resolve('随便什么数据');
    }, 2000);
});
*/


function runAsync(){
    var p = new Promise(function(resolve, reject){
        //做一些异步操作
        setTimeout(function(){
            console.log('执行完成');
            resolve('随便什么数据');
        }, 2000);
    });
    return p;            
}
/*
runAsync()


runAsync().then(function(data){
    console.log(data);
    //后面可以用传过来的数据做些其他操作
    //......
});
*/

// 在runAsync()的返回上直接调用then方法，then接收一个参数，是函数，并且会拿到我们在runAsync中调用resolve时传的的参数
// 而Promise的优势在于，可以在then方法中继续写Promise对象并返回，然后继续调用then来进行回调操作。


runAsync()
.then(function(data){
    console.log(data);
    return runAsync();
})
.then(function(data){
    console.log(data);
    return runAsync();
})
.then(function(data){
    console.log(data);
});


// 相关参考
// https://www.cnblogs.com/wenxuehai/p/10455664.html              JavaScript中的回调地狱及解决方法
// https://www.runoob.com/w3cnote/javascript-promise-object.html  JavaScript Promise 对象
// https://blog.csdn.net/hyupeng1006/article/details/80351174     ES6---new Promise()讲解
	// 用Promise的时候一般是包在一个函数中，在需要的时候去运行这个函数，
	
	
/*
1. resolve的作用：用于 .then()方法中的函数回调
2. 


*/
