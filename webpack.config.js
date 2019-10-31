const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = {
    entry: {
        index: './src/index.js',
    },
    devtool: 'inline-source-map',
    plugins: [
        new CleanWebpackPlugin(['dist']),
        new HtmlWebpackPlugin({
            title: 'My Website',
            template: path.resolve(__dirname, 'src/', 'index.html'),
            inject: true
        })
    ],
    module: {
        rules: [
            {
                test: /\.(scss|css)$/,
                use: ['style-loader','css-loader', 'sass-loader']
            },
            {
                test: /\.(png|ico|svg|jpg|gif)$/,
                use: [
                    'file-loader?name=./images/[name].[ext]'
                ]
            },
            {
                test: /\.(html)$/,
                use: {
                    loader: 'html-loader',
                    options: {
                        attrs: ['img:src', 'link:href']
                    }
                }
            },
        ]
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
    optimization: {
        splitChunks: {
            chunks: 'all'
        }
    }
};
