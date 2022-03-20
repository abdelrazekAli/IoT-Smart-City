const jwt = require("jsonwebtoken");
const { JWT_TOKEN_SECRET } = process.env;

module.exports = (userData) => {
  return jwt.sign(userData, JWT_TOKEN_SECRET);
};
