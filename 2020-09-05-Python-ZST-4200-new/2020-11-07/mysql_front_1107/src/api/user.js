import request from '../util/requests'

export let getCurrentUser = () => {
    return request.get('/user/current_user/')
}


export let logout = () => {
    return request.get('/user/logout_user/')
}

export let login = (data) => {
    return request.post("/user/django_ldap_login/", data)
}
