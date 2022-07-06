const { DB_URL } = process.env;
const mongoose = require("mongoose");
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const homeSchema = mongoose.Schema(
  {
    degrees: Array,
    lights: Array,
  },
  { versionKey: false }
);

const Home = mongoose.model("home", homeSchema);

exports.getHomeDegrees = async () => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOne();
    console.log("result", result);
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

exports.getHomeLights = async () => {
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

exports.updateHomeLights = async (data) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOneAndUpdate(
      {},
      {
        lights: data,
      },
      { new: true, upsert: true }
    );
    mongoose.disconnect();
    return result.lights;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};
