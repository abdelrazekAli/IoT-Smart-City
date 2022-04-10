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
    let { slots } = req.body;
    if (!slots)
      return res.status(200).send({
        status: false,
        message: "slots array is required",
        data: null,
      });

    const result = await parkingModel.updateParkingSlots(slots);

    const { _id, ...data } = result._doc;
    res.status(200).send({
      status: true,
      message: "Update slots Success",
      data,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed",
      data: null,
    });
    console.log(err);
  }
};