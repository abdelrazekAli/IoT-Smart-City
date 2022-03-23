const { DB_URL } = process.env;
const mongoose = require("mongoose");
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const tokenSchema = mongoose.Schema({
  token: String,
});

const Token = mongoose.model("token", tokenSchema);

exports.createNewToken = async (token) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);

    let newToken = new Token({
      token: token,
    });

    let result = await newToken.save();
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.checkToken = async (token) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);

    let result = await Token.find({ token: token });
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.deleteToken = async (token) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);

    let result = await Token.deleteOne({ token: token });
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};
