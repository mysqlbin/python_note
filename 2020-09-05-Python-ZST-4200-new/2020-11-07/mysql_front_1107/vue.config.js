module.exports = {
   configureWebpack: {
       devtool: 'source-map'
   },
   devServer: {
       proxy: {
           '/api': {
               target: 'http://localhost:8001',
               ws: true,
               changeOrigin: true
           }
       }
   }
}


