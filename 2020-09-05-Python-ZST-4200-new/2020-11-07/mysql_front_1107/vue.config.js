module.exports = {
   configureWebpack: {
       devtool: 'source-map'
   },
   devServer: {
       proxy: {
           '/api': {
               target: 'http://192.168.0.45:8001/',
               ws: true,
               changeOrigin: true
           }
       }
   }
}


