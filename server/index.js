if (!process.env.PORT || !process.env.MONGO_URL) require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const app = express();

// const adminRouter = require();
const authRouter = require("./routes/auth");
// const userRouter = require();
//const productRouter = require();

const PORT = process.env.PORT || 3000;
const DB = process.env.MONGO_URL;

app.use(express.json());
app.use(authRouter);
mongoose.set(`strictQuery`, true);

mongoose
	.connect(DB, {})
	.then(() => console.log("Connection Successful"))
	.catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => console.log(`Connected at port ${PORT}`));
