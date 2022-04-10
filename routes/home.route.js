const router = require("express").Router();
const {
  updateHomeTemp,
  getHomeTemp,
} = require("../controllers/home.controller");

router.get("/temp", getHomeTemp);
router.post("/temp", updateHomeTemp);

module.exports = router;
