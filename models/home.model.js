const { DB_URL } = process.env;
const mongoose = require("mongoose");
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const homeSchema = mongoose.Schema(
  {
    degrees: Array,
    password: Number,
    led1: Number,
    led2: Number,
    led3: Number,
    led4: Number,
    led5: Number,
    led6: Number,
  },
  { versionKey: false }
);

const Home = mongoose.model("home", homeSchema);

exports.getHomeData = async () => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOne();
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.updateHomeDegrees = async (data) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOneAndUpdate(
      {},
      {
        degrees: data,
      },
      { new: true, upsert: true }
    );
    mongoose.disconnect();
    return result.degrees;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.updateHomePass = async (pass) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOneAndUpdate(
      {},
      {
        password: pass,
      },
      { new: true, upsert: true }
    );
    mongoose.disconnect();
    return result.password;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.updateHomeLights = async (data) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOneAndUpdate(
      {},
      {
        $set: data,
      },
      { new: true, upsert: true }
    );
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};
