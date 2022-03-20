const router = require("express").Router();
const auth = require("./guards/auth.guard");

// Import user controllers
const {
  getUser,
  createNewUser,
  login,
  updateUser,
} = require("../controllers/user.controller");

router.get("/:id", getUser);
router.post("/register", createNewUser);
router.post("/login", login);
router.put("/:id", auth, updateUser);

module.exports = router;
