const bcrypt = require("bcrypt");
const { userValidation } = require("../utils/validation");
const generateAccessToken = require("../utils/token");
const userModel = require("../models/user.model");
const tokenModel = require("../models/token.model");

exports.getUser = async (req, res) => {
  try {
    let userId = req.params.id;

    let checkResult = await userModel.checkId(userId);
    if (checkResult)
      return res.status(200).send({
        status: false,
        message: checkResult,
        data: null,
      });

    let user = await userModel.getUserDetails(userId);
    let { password, ...others } = user._doc;
    res.status(200).json({
      status: true,
      message: "",
      data: others,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Faild to get user",
      data: null,
    });
  }
};

exports.createNewUser = async (req, res) => {
  try {
    let { username, email, password, phone, carInt, carStr } = req.body;
    if (!username || !email || !password || !phone || !carInt || !carStr) {
      return res.status(200).send({
        status: false,
        message: "All user data are required",
        data: null,
      });
    }

    let validationResult = userValidation(req.body);
    if (validationResult)
      return res.status(200).send({
        status: false,
        message: validationResult.details[0].message,
        data: null,
      });
    let result = await userModel.createNewUser(
      username,
      email,
      password,
      phone,
      carInt,
      carStr
    );
    if (typeof result === "string") {
      res.status(200).send({
        status: false,
        message: result,
        data: null,
      });
    } else {
      let { password, ...data } = result._doc;
      res.status(200).send({
        status: true,
        message: "User successfully added",
        data,
      });
    }
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to create new user",
      data: null,
    });
    console.log(err);
  }
};

exports.login = async (req, res) => {
  try {
    let { email, password } = req.body;

    // Check email and password
    if (!email || !password)
      res.status(200).send("Email and password are required");
    let validationResult = userValidation(req.body);
    if (validationResult)
      return res.status(200).send({
        status: false,
        message: validationResult.details[0].message,
        data: null,
      });

    // Check if email exist
    let user = await userModel.getUserByEmail(email);
    if (!user)
      return res.status(200).send({
        status: false,
        message: "Invalid email or password",
        data: null,
      });

    // Check if password is correct
    let compareResult = await bcrypt.compare(password, user.password);
    if (!compareResult)
      return res.status(200).send({
        status: false,
        message: "Invalid email or password",
        data: null,
      });

    // Create and assign a token
    let accessToken = generateAccessToken({ _id: user._id });

    // Save access token to database
    await tokenModel.createNewToken(accessToken);

    res.header("Authorization", accessToken).json({
      status: true,
      message: "Login success",
      data: {
        _id: user._id,
        username: user.username,
        email: user.email,
        phone: user.phone,
        carInt: user.carInt,
        carStr: user.carStr,
        token: accessToken,
      },
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Faild to login",
      data: null,
    });
  }
};

// exports.logout = async (req, res) => {
//   try {
//     const { token } = req.body;
//     if (!token) return res.status(200).send("token is required");

//     // Check token in database
//     let result = await tokenModel.checkToken(token);
//     if (result.length === 0) return res.status(200).send("Invalid token");

//     // Delete token from database
//     await tokenModel.deleteToken(token);

//     res.status(204).send("Successfully logout");
//   } catch (err) {
//     res.status(200).send("Failed to logout");
//     console.log(err);
//   }
// };

// exports.refreshToken = async (req, res) => {
//   const refreshToken = req.body.token;
//   try {
//     if (!refreshToken) return res.status(200).send("token is required");

//     // Check token in database
//     let token = await tokenModel.checkToken(refreshToken);
//     if (token.length === 0) return res.status(200).send("Invalid token");

//     jwt.verify(refreshToken, JWT_TOKEN_SECRET, (err, user) => {
//       if (err) return res.status(200).send("Invalid token");
//       const accessToken = generateAccessToken({ _id: user._id });
//       res.status(200).send({ accessToken: accessToken });
//     });
//   } catch (err) {
//     res.status(200).send("Failed to refresh token");
//     console.log(err);
//   }
// };

exports.updateUser = async (req, res) => {
  try {
    let id = req.params.id;

    // Check user id
    let checkResult = await userModel.checkId(id);
    if (checkResult)
      return res.status(200).send({
        status: false,
        message: checkResult,
        data: null,
      });

    if (req.user._id === id) {
      let { username, email, phone, carInt, carStr } = req.body;
      let validationResult = userValidation(req.body);
      if (validationResult)
        return res.status(200).send({
          status: false,
          message: validationResult.details[0].message,
          data: null,
        });

      let result = await userModel.updateUser(
        id,
        username,
        email,
        phone,
        carInt,
        carStr
      );
      if (typeof result === "string") {
        res.status(200).send({
          status: false,
          message: result,
          data: null,
        });
      } else {
        let { password, ...data } = result._doc;
        res.status(200).send({
          status: true,
          message: "Update success",
          data,
        });
      }
    } else
      return res.status(200).send({
        status: false,
        message: "You can only update your account",
        data: null,
      });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to update user",
      data: null,
    });
    console.log(err);
  }
};
