const { environment } = require('@rails/webpacker');

// Babel loader configuration
const babelLoader = {
  test: /\.js$/,
  exclude: /node_modules/,
  use: 'babel-loader'
};
environment.loaders.append('babel', babelLoader);

// Custom configuration
const customConfig = {
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