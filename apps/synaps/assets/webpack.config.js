const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => {
    const devMode = options.mode !== 'production';
    process.env.NODE_ENV = options.mode;

    return {
        optimization: {
            minimizer: [
                new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
                new OptimizeCSSAssetsPlugin({})
            ]
        },
        entry: {
            'app': glob.sync('./vendor/**/*.js').concat(['./js/app.js']),
            'demo': ['./js/views/demo.js', './css/demo.scss'].concat(glob.sync('./vendor/**/*.js')),
            'demo2': './css/demo2.scss',
            'kontakt': ['./js/views/kontakt.js', './css/kontakt.scss'].concat(glob.sync('./vendor/**/*.js')),
            'login': ['./js/views/login.js'].concat(glob.sync('./vendor/**/*.js')),
        },
        output: {
            filename: '[name].js',
            path: path.resolve(__dirname, '../priv/static/js'),
            publicPath: '/js/'
        },
        devtool: devMode ? 'source-map' : undefined,
        module: {
            rules: [{
                    test: /\.js$/,
                    exclude: /node_modules/,
                    use: {
                        loader: 'babel-loader'
                    }
                },
                {
                    test: /\.[s]?css$/,
                    use: [
                        MiniCssExtractPlugin.loader,
                        'css-loader',
                        'sass-loader',
                        'postcss-loader'
                    ]
                }
            ]
        },
        plugins: [
            new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
            new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
        ]
    }
};