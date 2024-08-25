const path = require('path');

module.exports = {
  mode: 'production',
  entry: './app/javascript/channels/index.js', // エントリーポイントを指定
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist') // 出力先を指定
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      }
    ]
  }
};