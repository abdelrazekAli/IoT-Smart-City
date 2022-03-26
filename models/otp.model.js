const { DB_URL } = process.env;
const mongoose = require("mongoose");
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const otpSchema = mongoose.Schema({
  email: String,
  otp: String,
});

const Otp = mongoose.model("otp", otpSchema);

exports.createNewOtp = async (otp, email) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);

    let newOtp = new Otp({
      email: email,
      otp: otp,
    });

    let result = await newOtp.save();
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.checkOtp = async (email, otp) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);

    let result = await Otp.findOne({ email: email, otp: otp });
    console.log(result);
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.deleteOtp = async (email) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);

    let result = await Otp.deleteMany({ email: email });
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};
