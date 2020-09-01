module.exports = {
    devServer: {
        proxy: {
            '/api': {   // api 开头的转发到 http://localhost:8089/， 
                target: 'http://localhost:8089/',
                ws: true,
                changeOrigin: true
            }
        }
    }
}


