const { DB_URL } = process.env;
const mongoose = require("mongoose");
const connectOptions = { useNewUrlParser: true, useUnifiedTopology: true };

const parkingSchema = mongoose.Schema(
  {
    slots: Array,
  },
  { versionKey: false }
);

const Parking = mongoose.model("parking", parkingSchema);

exports.getParkingSlots = async () => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Parking.findOne();
    mongoose.disconnect();
    return result;
  } catch (err) {
    mongoose.disconnect();
    throw new Error(err);
  }
};

exports.updateParkingSlots = async (data) => {
  try {
    await mongoose.connect(DB_URL, connectOptions);
    const result = await Parking.findOneAndUpdate(
      {},
      {
        slots: data,
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
