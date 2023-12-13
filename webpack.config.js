const path = require('path');
// 本番環境用のプラグインをインポートする場合

module.exports = {
  mode: 'production',
  entry: './path/to/your/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      }
      // 他のローダーやプラグインの設定
    ]
  },
  // 本番環境向けの追加設定
};