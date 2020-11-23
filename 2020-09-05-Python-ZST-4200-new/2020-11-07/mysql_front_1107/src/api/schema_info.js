
import request from '../util/requests'



export let getSchemaNameList = () => {
    return request.get("/meta_manage/mysql_schema/")
}

