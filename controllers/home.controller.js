const homeModel = require("../models/home.model");

exports.getHomeDegrees = async (req, res) => {
  try {
    const result = await homeModel.getHomeDegrees();
    const { degrees } = result._doc;

    res.status(200).json({
      status: true,
      message: "",
      data: { degrees },
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Faild to get home degrees",
      data: null,
    });
  }
};

exports.updateHomeDegrees = async (req, res) => {
  try {
    let { degrees } = req.body;

    // Check for degrees
    if (!degrees) {
      return res.status(200).send({
        status: false,
        message: "degrees are required",
        data: null,
      });
    }

    // Convert degrees string to array of binary numbers
    const degreesArr = degrees
      .slice(1, degrees.length - 1)
      .split(",")
      .map((s) => Number(s));

    // Update degrees in DB
    const result = await homeModel.updateHomeDegrees(degreesArr);

    // Response
    return res.status(200).send({
      status: true,
      message: "Update home degrees success",
      data: { degrees: result },
    });
  } catch (err) {
    console.log(err);
    return res.status(200).send({
      status: false,
      message: "Failed to update home degrees",
      data: null,
    });
  }
};

exports.getHomeLights = async (req, res) => {
  try {
    const result = await homeModel.getHomeLights();
    const { _id, degrees, ...data } = result._doc;

    res.status(200).json({
      status: true,
      message: "",
      data,
    });
  } catch (err) {
    console.log(err);
    res.status(200).send({
      status: false,
      message: "Faild to get home lights",
      data: null,
    });
  }
};

exports.updateHomeLights = async (req, res) => {
  try {
    // Check for lights
    if (Object.keys(req.body).length === 0) {
      return res.status(200).send({
        status: false,
        message: "data is required",
        data: null,
      });
    }

    // Update lights in DB
    const result = await homeModel.updateHomeLights(req.body);
    const { _id, degrees, ...data } = result._doc;

    // Response
    return res.status(200).send({
      status: true,
      message: "Update home lights success",
      data,
    });
  } catch (err) {
    console.log(err);
    return res.status(200).send({
      status: false,
      message: "Failed to update home lights",
      data: null,
    });
  }
};
