const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");

require("dotenv").config();

//Register Route
router.post("/register", async (req, res) => {
    const { userName, email, password } = req.body;

    if (!userName || !email || !password) {
        return res.status(400).json({ msg: "Please Fill All The Fields!" });
    };

    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User Already Exists!" });
        };

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        const newUser = new User({
            userName,
            email,
            password: hashedPassword,
        });

        const savedUser = await newUser.save();
        const token = jwt.sign({ id: savedUser._id }, process.env.JWT_SECRET, {
            expiresIn: "2h",
        });
        res.json({
            token, user: {
                id: savedUser._id,
                userName: savedUser.userName,
                email: savedUser.email,
            }
        });
    } catch (error) {
        res.status(500).json({ msg: "Error Occurred On Server Side!" });
    };
});

//Login Route
router.post("/login", async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).json({ msg: "Please Fill All The Fields!" });
    }
    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User Doesn't Exist!" });
        };

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "password Doesn't match!" });
        }

        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
            expiresIn: "2h",
        });

        res.json({
            token,
            user: {
                id: user._id,
                userName: user.userName,
                email: user.email,
            },
            message: "You Logged Successfully!",
        });
    } catch (error) {
        res.status(500).json({ msg: "Error Occurred On Server Side!" });
    }
});

module.exports = router;