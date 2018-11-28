const colors = {
  black: "#7F7F7F",
  red: "#f76c78",
  green: "#7cffbb",
  yellow: "#ffe9b7",
  blue: "#6b97e0",
  magenta: "#ffbcff",
  cyan: "#bedeea",
  white: "#d0d0d0",
  lightBlack: "#808080",
  lightRed: "#f1a5ab",
  lightGreen: "#b2ffd7",
  lightYellow: "#fffac4",
  lightBlue: "#8da4e0",
  lightMagenta: "#efd7ec",
  lightCyan: "#bfeef2",
  lightWhite: "#d4d4d4"
};

exports.decorateConfig = config =>
  Object.assign({}, config, {
    backgroundColor: "#2c3141",
    colors
  });
