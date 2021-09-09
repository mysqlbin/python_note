module.exports = {
   configureWebpack: {
       devtool: 'source-map'
   },
   devServer: {
       proxy: {
           '/api': {
               // target: 'http://192.168.0.45:8001/',
               target: 'http://localhost:8091/',
               ws: true,
               changeOrigin: true
           }
       }
   }
}


