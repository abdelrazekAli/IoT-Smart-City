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
    const { _id, ...data } = result._doc;
    return res.status(200).send({
      status: true,
      message: "Update home degrees success",
      data,
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
    const { lights } = result._doc;

    res.status(200).json({
      status: true,
      message: "",
      data: { lights },
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Faild to get home lights",
      data: null,
    });
  }
};

exports.updateHomeLights = async (req, res) => {
  try {
    let { lights } = req.body;

    // Check for lights
    if (!lights) {
      return res.status(200).send({
        status: false,
        message: "lights are required",
        data: null,
      });
    }

    // Convert lights string to array of binary numbers
    const lightsArr = lights
      .slice(1, lights.length - 1)
      .split(",")
      .map((s) => Number(s));

    // Update lights in DB
    const result = await homeModel.updateHomeLights(lightsArr);

    // Response
    const { _id, ...data } = result._doc;
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
