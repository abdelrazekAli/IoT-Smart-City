const router = require("express").Router();
const {
  getHomeDegrees,
  updateHomeDegrees,
  getHomeLights,
  updateHomeLights,
} = require("../controllers/home.controller");

router.get("/degrees", getHomeDegrees);
router.post("/degrees", updateHomeDegrees);
router.get("/lights", getHomeLights);
router.post("/lights", updateHomeLights);

module.exports = router;
