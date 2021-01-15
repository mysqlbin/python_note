
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




