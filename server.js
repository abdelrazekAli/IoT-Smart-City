const express = require("express");
const app = express();
const cors = require("cors");
const dotenv = require("dotenv").config();

// Import Routes
const userRouter = require("./routes/user.route");
const parkingRouter = require("./routes/parking.route");

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Routes Middlewares
app.use("/api/users", userRouter);
app.use("/api/parking", parkingRouter);

const PORT = process.env.PORT || 5000;
app.listen(PORT);
