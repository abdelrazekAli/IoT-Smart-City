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
      message: "Faild to get parking slots",
      data: null,
    });
  }
};

exports.updateParkingSlots = async (req, res) => {
  try {
    let { slots } = req.body;
    console.log(slots);
    // Check for slots
    if (!slots) {
      return res.status(200).send({
        status: false,
        message: "slots are required",
        data: null,
      });
    }

    // Convert slots string to array of binary numbers
    const slotsArr = slots
      .slice(1, slots.length - 1)
      .split(",")
      .map((s) => Number(s));

    // Update slots in DB
    const result = await parkingModel.updateParkingSlots(slotsArr);

    // Response
    const { _id, ...data } = result._doc;
    return res.status(200).send({
      status: true,
      message: "Update slots success",
      data,
    });
  } catch (err) {
    console.log(err);
    return res.status(200).send({
      status: false,
      message: "Failed to update slots",
      data: null,
    });
  }
};
