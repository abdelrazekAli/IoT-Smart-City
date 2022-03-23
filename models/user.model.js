const bcrypt = require("bcrypt");
const { DB_URL } = process.env;
const mongoose = require("mongoose");
const { ObjectId } = require("mongoose").Types;
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const userSchema = mongoose.Schema(
  {
    username: String,
    email: { type: String, unique: true },
    password: String,
    phone: String,
    carInt: String,
    carStr: String,
  },
  { versionKey: false } //To ignore __v
);

const User = mongoose.model("user", userSchema);

exports.getUserDetails = async (userId) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    let user = await User.findById(userId);
    mongoose.disconnect();
    return user;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.createNewUser = async (
  username,
  email,
  password,
  phone,
  carInt,
  carStr
) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    let emailCheck = await User.findOne({ email: email });
    if (emailCheck) return `Email : ${email} is already used`;
    else {
      //Encrypt user password
      let hashedPassword = await bcrypt.hash(password, 10);

      let newUser = new User({
        username: username,
        email: email,
        password: hashedPassword,
        phone: phone,
        carInt: carInt,
        carStr: carStr,
      });
      let res = await newUser.save();
      mongoose.disconnect();
      return res;
    }
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.updateUser = async (id, username, email, phone, carInt, carStr) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    let user = await User.findById(id);
    if (user.email !== email) {
      let emailCheck = await User.findOne({ email: email });
      if (emailCheck) return "Email is already used";
    }
    let res = await User.findByIdAndUpdate(
      id,
      {
        username: username,
        email: email,
        phone: phone,
        carInt: carInt,
        carStr: carStr,
      },
      { new: true }
    );

    mongoose.disconnect();
    return res;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.getUserByEmail = async (email) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    let user = await User.findOne({ email: email });
    mongoose.disconnect();
    return user;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.checkId = async (id) => {
  try {
    if (ObjectId.isValid(id)) {
      await mongoose.connect(DB_URL, connectOptions);
      let user = await User.findById(id);
      mongoose.disconnect();
      if (user === null) return "User is not exist";
    } else return "User id is not valid";
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};