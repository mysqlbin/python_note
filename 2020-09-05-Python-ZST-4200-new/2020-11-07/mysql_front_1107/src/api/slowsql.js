
import request from '../util/requests'

export let getSlowSqlList = (params) => {
    return request({
        url: '/slowsql/slow_sql/',
        method: 'get',
        params: params
    })
}

export let getAggsByDate = (params)=> {
    return request({
        url: '/slowsql/slow_sql/get_aggs_by_date/',
        method: 'get',
        params: params
    })
}

export let getSlowSqlTop10 = (params) => {
    return request({
        url: '/slowsql/slow_sql/get_top10_sql/',
        method: 'get',
        params: params
    })
}

export let getAggsBySchema = (params) => {
    return request({
        url: '/slowsql/slow_sql/get_aggs_by_schema/',
        method: 'get',
        params: params
    })
}

