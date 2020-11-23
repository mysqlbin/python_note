import request from '../util/requests'

export let getCurrentUser = () => {
    return request.get('/user/current_user/')
}
