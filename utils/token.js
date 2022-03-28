const jwt = require("jsonwebtoken");
const { JWT_TOKEN_SECRET } = process.env;

const { TokenExpiredError } = jwt;
exports.catchExpireError = (err, res) => {
  if (err instanceof TokenExpiredError)
    return res.status(200).send({
      status: false,
      message: "Access Token was expired",
      data: null,
    });
  return res.status(200).send({
    status: false,
    message: "Invalid token",
    data: null,
  });
};

exports.generateAccessToken = (userData) => {
  return jwt.sign(userData, JWT_TOKEN_SECRET);
};

exports.generatePassResetToken = () => {
  return jwt.sign(
    {
      data: "password-reset",
    },
    JWT_TOKEN_SECRET,
    { expiresIn: "3h" }
  );
};
