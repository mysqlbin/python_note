
// 导入
import {sub} from './sub'

// 导出
// export function sum(a, b){   
//     return a+b + sub(a, b);
// }

let sum = function sum(a, b){   
        return a+b + sub(a, b);
    }
    
// 导出重命名
// export {sum as suma}


// 默认导出
export default sum
