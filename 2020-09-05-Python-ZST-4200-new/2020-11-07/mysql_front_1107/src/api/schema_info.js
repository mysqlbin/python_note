
import request from '../util/requests'



export let getSchemaNameList = () => {
    return request.get("/meta_manage/mysql_schema/get_distinct_schema_names/")
}

/*
export let getSchemaList = () => {
    return request.get("/meta_manage/mysql_schema/")
}
*/

export let getSchemaList = (params) => {
    return request({
        url: '/meta_manage/mysql_schema/',
        method: 'get',
        params: params
    })
}



export let getSchemaPorcesslist = (schemaId) => {
    return request.get(`/meta_manage/mysql_schema/${schemaId}/get_schema_processlist`)
}


export let killProcessById = (schemaId, processId) => {
    return request.delete(`/meta_manage/mysql_schema/${schemaId}/kill_processlist_by_id`, {data: {process_id: processId}})
}



