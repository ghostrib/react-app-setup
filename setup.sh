#!/bin/bash

bold=$(tput bold)
reset=$(tput sgr0)

mkdir "$1" && cd "$1" || exit 1;

echo -e "\n${bold}Creating a new react project in${reset} \033[32;1m$(pwd)\033[0m\n"

 # if you want to see the output of the install, remove the `1>/dev/null`
npm init -y 1>/dev/null
npm install webpack webpack-cli html-webpack-plugin @babel/core babel-loader @babel/preset-env @babel/preset-react @babel/plugin-proposal-class-properties webpack-dev-server style-loader css-loader --save-dev 1>/dev/null

touch .babelrc
echo '{
  "presets": ["@babel/preset-env", "@babel/preset-react"],
  "plugins": ["@babel/plugin-proposal-class-properties"]
}' > .babelrc

touch webpack.config.js
echo 'const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  // this entry point assumes you are rendering your app at ./client/index.js
  // if your folder and/or filenames are different you will need to change this accordingly
  entry: "./client/index.js",
  output: {
    // the output path and filename in which webpack will bundle your files
    // when webpack bundles your files, it will place the file `bundle.js`
    // inside a newly created `dist` folder in your projects root directory
    path: path.join(__dirname, "/dist"),
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      },
      {
        // this configuration allows you to use css-modules in your react app
        test: /\.css$/,
        loader:
          "style-loader!css-loader?modules=true&localIdentName=[name]__[local]___[hash:base64:5]"
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      // make sure this matches your entry point above
      template: "./client/index.html"
    })
  ]
};' > webpack.config.js

 # if you want to see the output of the install, remove the `1>/dev/null`
npm install react react-dom --save 1>/dev/null

mkdir -p client
cd client && touch App.js index.html index.js

echo 'import React, { Component } from "react";

class App extends Component {

  render() {
    return (
      <div>
        <h1>HELLO WORLD</h1>
      </div>
    )
  }
}

export default App;' > App.js

echo 'import React from "react";
import ReactDOM from "react-dom";
import App from "./App";

ReactDOM.render(<App />, document.getElementById("root"));' > index.js

echo '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Document</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>' > index.html

echo -e "${bold}webpack and webpack-dev-server have been installed
consider adding these scripts to your package.json${reset}

  \033[32;1m\"start\": \"webpack-dev-server --open --hot\",
  \"build\": \"webpack --mode production\",
  \"watch\": \"webpack --mode development --watch\"\033[0m
"

echo -e "${bold}To get started:${reset}

  \033[32;1mcd "$1" && code .\033[0m
"


