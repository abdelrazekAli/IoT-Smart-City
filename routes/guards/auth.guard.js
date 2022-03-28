const jwt = require("jsonwebtoken");
const { catchExpireError } = require("../../utils/token");

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
