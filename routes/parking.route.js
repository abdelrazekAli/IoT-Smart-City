const router = require("express").Router();
const {
  updateParkingSlots,
  getParkingSlots,
} = require("../controllers/parking.controller");

router.get("/slots", getParkingSlots);
router.post("/slots", updateParkingSlots);

module.exports = router;
