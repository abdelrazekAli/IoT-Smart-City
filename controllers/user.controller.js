const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const mailer = require("../utils/mailer");
const otpModel = require("../models/otp.model");
const userModel = require("../models/user.model");
const {
  generateAccessToken,
  generatePassResetToken,
} = require("../utils/token");
const { catchExpireError } = require("../utils/token");
const { userValidation, passwordValidation } = require("../utils/validation");

exports.getUser = async (req, res) => {
  try {
    let userId = req.params.id;

    // Check user id
    let checkResult = await userModel.checkId(userId);
    typeof checkResult === "string"
      ? res.status(200).send({
          status: false,
          message: checkResult,
          data: null,
        })
      : (user = checkResult);

    let { password, isVerify, ...others } = user._doc;
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
      let { password, isVerify, ...data } = result._doc;
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
      res.status(200).send({
        status: false,
        message: "Email and password are required",
        data: null,
      });

    let validationResult = userValidation({ email });
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

    if (!user.isVerify)
      return res.status(200).send({
        status: false,
        message: "Your email is not verified",
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
    console.log(err);
  }
};

exports.updateUser = async (req, res) => {
  try {
    let { id } = req.params;

    // Check user id
    let checkResult = await userModel.checkId(id);
    typeof checkResult === "string"
      ? res.status(200).send({
          status: false,
          message: checkResult,
          data: null,
        })
      : (user = checkResult);

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
        let { password, isVerify, ...data } = result._doc;
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
  }
};

exports.changePassword = async (req, res) => {
  try {
    let { id } = req.params;
    let { oldPassword, newPassword } = req.body;

    // Check user id
    let checkResult = await userModel.checkId(id);
    typeof checkResult === "string"
      ? res.status(200).send({
          status: false,
          message: checkResult,
          data: null,
        })
      : (user = checkResult);

    if (req.user._id === id) {
      // Validate password
      let validationResult = passwordValidation(req.body);
      if (validationResult)
        return res.status(200).send({
          status: false,
          message: validationResult.details[0].message,
          data: null,
        });

      // Check passwords
      if (oldPassword === newPassword) {
        return res.status(200).send({
          status: false,
          message: "Old and new password are the same",
          data: null,
        });
      }

      // Check user old passowrd
      let compareResult = await bcrypt.compare(oldPassword, user.password);
      if (!compareResult)
        return res.status(200).send({
          status: false,
          message: "Old password not correct",
          data: null,
        });

      // Change password
      await userModel.changePassword(id, newPassword);
      res.status(200).send({
        status: true,
        message: "Change password success",
        data: null,
      });
    } else
      return res.status(200).send({
        status: false,
        message: "You can only change your account password",
        data: null,
      });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to change password",
      data: null,
    });
  }
};

exports.verifyEmail = async (req, res) => {
  try {
    const { email, otp } = req.body;
    if (!email || !otp)
      return res.status(200).send({
        status: false,
        message: "Email and otp are required",
        data: null,
      });

    let validationResult = userValidation(req.body);
    if (validationResult)
      return res.status(200).send({
        status: false,
        message: validationResult.details[0].message,
        data: null,
      });

    const user = await userModel.getUserByEmail(email);
    if (!user)
      return res.status(200).send({
        status: false,
        message: "Email is not registered",
        data: null,
      });

    if (user.isVerify)
      return res.status(200).send({
        status: false,
        message: "Email is already verified",
        data: null,
      });

    let checkOtp = await otpModel.checkOtp(email, otp);
    if (!checkOtp)
      return res.status(200).send({
        status: false,
        message: `Otp: ${otp} is invalid`,
        data: null,
      });

    let result = await userModel.verifyEmail(email);
    await otpModel.deleteOtp(email);
    let { password, isVerify, ...data } = result._doc;
    res.status(200).send({
      status: true,
      message: "Email verify success",
      data,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to verify email",
      data: null,
    });
  }
};

exports.sendOtp = async (req, res) => {
  try {
    const { email } = req.body;
    if (!email)
      return res.status(200).send({
        status: false,
        message: "Email is required",
        data: null,
      });

    let validationResult = userValidation({ email });
    if (validationResult)
      return res.status(200).send({
        status: false,
        message: validationResult.details[0].message,
        data: null,
      });

    const user = await userModel.getUserByEmail(email);
    if (!user) {
      return res.status(200).send({
        status: false,
        message: "Email is not registered",
        data: null,
      });
    }

    const otp = Math.floor(100000 + Math.random() * 900000);
    await otpModel.createNewOtp(otp, email);
    await mailer(otp, email);
    res.status(200).send({
      status: true,
      message: "Code sent, Please check your email",
      data: null,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to send otp",
      data: null,
    });
    console.log(err);
  }
};

exports.verifyOtp = async (req, res) => {
  try {
    const { email, otp } = req.body;
    if (!email || !otp)
      return res.status(200).send({
        status: false,
        message: "Email and otp are required",
        data: null,
      });

    let validationResult = userValidation(req.body);
    if (validationResult)
      return res.status(200).send({
        status: false,
        message: validationResult.details[0].message,
        data: null,
      });

    const user = await userModel.getUserByEmail(email);
    if (!user)
      return res.status(200).send({
        status: false,
        message: "Email is not registered",
        data: null,
      });

    if (!user.isVerify)
      return res.status(200).send({
        status: false,
        message: "Email is not verified",
        data: null,
      });

    let checkOtp = await otpModel.checkOtp(email, otp);
    if (!checkOtp)
      return res.status(200).send({
        status: false,
        message: `Otp: ${otp} is invalid`,
        data: null,
      });
    // Create password token
    const passToken = generatePassResetToken();

    // Store password token
    await userModel.passToken(email, passToken);

    // Delete otp
    await otpModel.deleteOtp(email);
    res.status(200).send({
      status: true,
      message: "Otp is correct",
      data: null,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to verify email",
      data: null,
    });
  }
};

exports.resetPassword = async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password)
      return res.status(200).send({
        status: false,
        message: "Email and password are required",
        data: null,
      });

    let validationResult = userValidation(req.body);
    if (validationResult)
      return res.status(200).send({
        status: false,
        message: validationResult.details[0].message,
        data: null,
      });

    const user = await userModel.getUserByEmail(email);
    if (!user)
      return res.status(200).send({
        status: false,
        message: "Email is not registered",
        data: null,
      });

    if (!user.isVerify)
      return res.status(200).send({
        status: false,
        message: "Email is not verified",
        data: null,
      });

    if (!user.resetPasswordToken)
      return res.status(200).send({
        status: false,
        message: "You should verify otp first",
        data: null,
      });

    // Check passsword token
    jwt.verify(
      user.resetPasswordToken,
      process.env.JWT_TOKEN_SECRET,
      (err, decode) => {
        if (err) return catchExpireError(err, res);
      }
    );
    await userModel.resetPassword(email, password);

    res.status(200).send({
      status: true,
      message: "reset password success",
      data: null,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to reset password",
      data: null,
    });
    console.log(err);
  }
};
