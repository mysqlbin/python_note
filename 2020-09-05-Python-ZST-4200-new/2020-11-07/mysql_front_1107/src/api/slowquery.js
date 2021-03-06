
import request from '../util/requests'

export let getSlowSqlList = (params) => {
    return request({
        url: '/slowquery/slowquery_history/',
        method: 'get',
        params: params
    })
}

export let getSlowSqlAggrList = (params) => {
    return request({
        url: '/slowquery/slowquery_aggr',
        method: 'get',
        params: params
    })
}

export let getAggsByDate = (params)=> {
    return request({
        url: '/slowquery/get_aggs_by_date/',
        method: 'get',
        params: params
    })
}



export let getAggsByInstance = (params) => {
    return request({
        url: '/slowquery/get_aggs_by_instance/',
        method: 'get',
        params: params
    })
}


export let getSlowSqlTop10 = (params) => {
    return request({
        url: '/slowquery/get_top10_sql/',
        method: 'get',
        params: params
    })
}






