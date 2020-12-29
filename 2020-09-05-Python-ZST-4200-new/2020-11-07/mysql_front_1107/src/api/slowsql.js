
import request from '../util/requests'



export let getSlowSqlList = (params) => {
    return request({
        url: '/slowsql/slow_sql/',
        method: 'get',
        params: params
    })
}



