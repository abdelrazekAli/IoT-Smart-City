const homeModel = require("../models/home.model");

exports.getHomeTemp = async (req, res) => {
  try {
    const temp = await homeModel.getHomeTemp();
    const { _id, ...data } = temp._doc;

    res.status(200).json({
      status: true,
      message: "",
      data,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Faild to get temp",
      data: null,
    });
    console.log(err);
  }
};

exports.updateHomeTemp = async (req, res) => {
  try {
    let { temp } = req.body;
    if (!temp)
      return res.status(200).send({
        status: false,
        message: "temp is required",
        data: null,
      });

    const result = await homeModel.updateHomeTemp(temp);

    const { _id, ...data } = result._doc;
    res.status(200).send({
      status: true,
      message: "Update temp Success",
      data,
    });
  } catch (err) {
    res.status(200).send({
      status: false,
      message: "Failed Update temp",
      data: null,
    });
    console.log(err);
  }
};
