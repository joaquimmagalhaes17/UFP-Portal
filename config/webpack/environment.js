const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
environment.loaders.append('vue', vue)

let sassLoader = environment.loaders.get('moduleSass');
let index = environment.loaders.get('moduleSass').use.findIndex(el => el.loader === 'css-loader');

sassLoader.use[index].options = {
    modules: true,
    sourceMap: true,
    localIdentName: '[name]__[local]___[hash:base64:5]'
};

environment.loaders.append('css', {
    test: /\.css$/,
    use: [ 'style-loader', 'css-loader' ]
})

module.exports = environment
