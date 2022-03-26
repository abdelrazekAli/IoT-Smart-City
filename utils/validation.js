const Joi = require("joi");
const { joiPassword } = require("joi-password");

exports.userValidation = (data) => {
  const schema = Joi.object({
    username: Joi.string().min(2).max(15),
    email: Joi.string().email({ tlds: { allow: ["com", "net"] } }),
    password: joiPassword
      .string()
      .minOfSpecialCharacters(1)
      .minOfUppercase(1)
      .minOfNumeric(3)
      .noWhiteSpaces()
      .min(8),
    phone: Joi.string().min(11).max(15),
    carInt: Joi.string().min(1).max(5),
    carStr: Joi.string().min(1).max(5),
    otp: Joi.string().length(6).message("Otp length must be 6 numbers long"),
  });
  return schema.validate(data).error;
};

exports.passwordValidation = (data) => {
  const schema = Joi.object({
    oldPassword: Joi.string().required(),
    newPassword: joiPassword
      .string()
      .minOfSpecialCharacters(1)
      .minOfUppercase(1)
      .minOfNumeric(2)
      .noWhiteSpaces()
      .min(8)
      .required(),
  });
  return schema.validate(data).error;
};
