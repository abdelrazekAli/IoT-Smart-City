const router = require("express").Router();
const auth = require("./guards/auth.guard");

// Import user controllers
const {
  getUser,
  createNewUser,
  login,
  sendOtp,
  updateUser,
  verifyEmail,
  changePassword,
} = require("../controllers/user.controller");

router.get("/:id", getUser);
router.post("/login", login);
router.post("/register", createNewUser);
router.post("/send-otp", sendOtp);
router.post("/verify-email", verifyEmail);
router.put("/:id", auth, updateUser);
router.put("/password-change/:id", auth, changePassword);

module.exports = router;
