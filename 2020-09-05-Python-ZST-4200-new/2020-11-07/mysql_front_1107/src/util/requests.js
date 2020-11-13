import axios from 'axios'

const request = axios.create({
    baseURL: '/user/api/',
    timeout: 30000
})

export default request