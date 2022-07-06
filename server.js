const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const cors = require("cors");
const dotenv = require("dotenv").config();

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
