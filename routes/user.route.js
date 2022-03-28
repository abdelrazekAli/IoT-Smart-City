const router = require("express").Router();
const auth = require("./guards/auth.guard");

// Import user controllers
const {
  getUser,
  createNewUser,
  login,
  sendOtp,
  updateUser,
  verifyOtp,
  verifyEmail,
  changePassword,
  resetPassword,
} = require("../controllers/user.controller");

router.get("/:id", getUser);
router.post("/login", login);
router.put("/:id", auth, updateUser);
router.post("/register", createNewUser);
router.post("/send-otp", sendOtp);
router.post("/verify-pass-otp", verifyOtp);
router.post("/verify-email", verifyEmail);
router.post("/password-reset", resetPassword);
router.put("/password-change/:id", auth, changePassword);

module.exports = router;
