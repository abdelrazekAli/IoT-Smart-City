const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const cors = require("cors");
const dotenv = require("dotenv").config();
const rateLimit = require("express-rate-limit");

// if we're behind a reverse proxy
app.set("trust proxy", 1);

// limit requests number to APIs
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 1000, // limit each IP to 1000 requests per windowMs
  message: "Too many requests, please try again later.",
});
app.use(limiter);

// Import Routes
const userRouter = require("./routes/user.route");
const homeRouter = require("./routes/home.route");
const parkingRouter = require("./routes/parking.route");

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Routes Middlewares
app.use("/api/home", homeRouter);
app.use("/api/users", userRouter);
app.use("/api/parking", parkingRouter);

const PORT = process.env.PORT || 5000;
server.listen(PORT);
