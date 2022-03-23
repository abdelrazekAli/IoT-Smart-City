const jwt = require("jsonwebtoken");

// Check token errors
const { TokenExpiredError } = jwt;
const catchExpireError = (err, res) => {
  if (err instanceof TokenExpiredError)
    return res.status(200).send({
      status: false,
      message: "Access Token was expired",
      data: null,
    });
  res.status(200).send({
    status: false,
    message: "Invalid token",
    data: null,
  });
};

module.exports = (req, res, next) => {
  const token = req.header("Authorization");
  if (!token)
    return res.status(200).send({
      status: false,
      message: "Access Denied. No token provided",
      data: null,
    });

  jwt.verify(token, process.env.JWT_TOKEN_SECRET, (err, decode) => {
    if (err) return catchExpireError(err, res);
    req.user = decode;
    next();
  });
};
