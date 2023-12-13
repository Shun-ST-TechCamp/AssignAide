const { environment } = require('@rails/webpacker');

// Babel loader configuration
const babelLoader = {
  test: /\.js$/,
  exclude: /node_modules/,
  use: 'babel-loader'
};
environment.loaders.append('babel', babelLoader);

// SCSS loader configuration
const scssLoader = {
  test: /\.scss$/,
  use: ['style-loader', 'css-loader', 'sass-loader']
};
environment.loaders.append('scss', scssLoader);

// Custom configuration
const customConfig = {
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  resolve: {
    fallback: {
      dgram: false,
      fs: false,
      net: false,
      tls: false,
      child_process: false
    }
  }
};

// Deleting node configurations
environment.config.delete('node.dgram');
environment.config.delete('node.fs');
environment.config.delete('node.net');
environment.config.delete('node.tls');
environment.config.delete('node.child_process');

// Merging custom configuration
environment.config.merge(customConfig);

module.exports = environment;