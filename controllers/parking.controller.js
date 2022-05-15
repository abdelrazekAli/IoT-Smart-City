const parkingModel = require("../models/parking.model");

exports.getParkingSlots = async (req, res) => {
  try {
    const slots = await parkingModel.getParkingSlots();
    const { _id, ...data } = slots._doc;

    res.status(200).json({
      status: true,
      message: "",
      data,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Faild to get slots",
      data: null,
    });
  }
};

exports.updateParkingSlots = async (req, res) => {
  try {
    let { slots } = req.query;

    // Convert slots Query string to array of numbers
    const slotsArr = slots.split(",").map((s) => Number(s));

    const result = await parkingModel.updateParkingSlots(slotsArr);

    const { _id, ...data } = result._doc;
    res.status(200).send({
      status: true,
      message: "Update slots success",
      data,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed to update slots",
      data: null,
    });
    console.log(err);
  }
};
