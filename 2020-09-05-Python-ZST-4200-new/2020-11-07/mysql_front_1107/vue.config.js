module.exports = {
   configureWebpack: {
       devtool: 'source-map'
   },
   devServer: {
       proxy: {
           '/user': {
               target: 'http://localhost:8001',
               ws: true,
               changeOrigin: true
           }
       }
   }
}


