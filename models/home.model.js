const { DB_URL } = process.env;
const mongoose = require("mongoose");
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const homeSchema = mongoose.Schema(
  {
    temp: String,
  },
  { versionKey: false }
);

const Home = mongoose.model("home", homeSchema);

exports.getHomeTemp = async () => {
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

exports.updateHomeTemp = async (temp) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Home.findOneAndUpdate(
      {},
      {
        temp: temp,
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
