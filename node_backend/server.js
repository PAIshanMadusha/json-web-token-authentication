const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

require("dotenv").config();

//Routes
const authenticationRoutes = require("./routes/authentication");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/auth", authenticationRoutes);

//DB
mongoose.connect(process.env.MONGODB_URL)
    .then(() => console.log("MongoDb Connected Successfully!"))
    .catch((error) => console.log(error));

//Port
const PORT = process.env.PORT || 5000;
app.listen(PORT, ()=> console.log(`Server Running On Port: ${PORT}`));