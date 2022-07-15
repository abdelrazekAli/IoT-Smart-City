const router = require("express").Router();
const {
  getHomeDegrees,
  updateHomeDegrees,
  getHomePass,
  updateHomePass,
  getHomeLights,
  updateHomeLights,
} = require("../controllers/home.controller");

router.get("/degrees", getHomeDegrees);
router.post("/degrees", updateHomeDegrees);
router.get("/pass", getHomePass);
router.post("/pass", updateHomePass);
router.get("/lights", getHomeLights);
router.post("/lights", updateHomeLights);

module.exports = router;
