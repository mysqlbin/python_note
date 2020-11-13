import request from '../util/requests'

export let login = (data) => {
    return request.post("/django_ldap_login/", data)
}