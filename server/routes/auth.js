const express = require("express");
const authRouter = express.Router();
const auth = require("../middleware/auth");
const {
	verifyPhone,
	signUpUser,
	getUser,
	checkUser,
} = require("../controllers/auth");

authRouter.post("/auth/checkUser", checkUser);

authRouter.post("/auth/verifyPhone", verifyPhone);

authRouter.post("/auth/signUpUser", signUpUser);

authRouter.get("/", auth, getUser);

module.exports = authRouter;
