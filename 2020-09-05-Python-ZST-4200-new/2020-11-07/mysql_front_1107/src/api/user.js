import request from '../util/requests'

export let getCurrentUser = () => {
    return request.get('/current_user/')
}
