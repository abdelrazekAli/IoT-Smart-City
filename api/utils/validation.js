const Joi = require("joi");

exports.userValidation = (data) => {
  const schema = Joi.object({
    username: Joi.string().min(2).max(255),
    email: Joi.string().email({ tlds: { allow: ["com", "net"] } }),
    password: Joi.string().min(3).max(255),
    phone: Joi.string().min(11).max(14),
    carInt: Joi.string().min(1).max(5),
    carStr: Joi.string().min(1).max(5),
  });
  return schema.validate(data).error;
};
