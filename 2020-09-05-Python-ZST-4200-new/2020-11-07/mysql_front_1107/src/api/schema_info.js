
import request from '../util/requests'



export let getSchemaNameList = () => {
    return request.get("/meta_manage/mysql_schema/get_distinct_schema_names/")
}

export let getSchemaList = () => {
    return request.get("/meta_manage/mysql_schema/")
}


export let getSchemaPorcesslist = (schemaId) => {
    return request.get(`/meta_manage/mysql_schema/${schemaId}/get_schema_processlist`)
}


