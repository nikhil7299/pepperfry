const User = require("../models/user");
const jwt = require("jsonwebtoken");

const JWT = process.env.JWT_SECRET;
const { TWILIO_SERVICE_SID, TWILIO_AUTH_TOKEN, TWILIO_ACCOUNT_SID } =
	process.env;

const client = require("twilio")(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, {
	lazyLoading: true,
});

const checkUser = async (req, res) => {
	try {
		const { phone } = req.body;
		console.log(phone);

		//Sending OTP
		const mobileOtpResponse = await client.verify.v2
			.services(TWILIO_SERVICE_SID)
			.verifications.create({ to: `+91${phone}`, channel: "sms" });
		console.log(mobileOtpResponse);

		const existingUser = await User.findOne({ phone });
		// const existingUser = await User.findOne({
		// 	$or: [{ email: mobileOrEmail }, { phone: phone }],
		// });

		console.log(existingUser);

		if (!existingUser) {
			return res
				.status(401)
				.json({ msg: "User Not registered, Enter OTP and SignUp Now" });
		} else
			return res.status(201).json({
				msg: "User Registerd, Enter OTP sent to registered Phone Number ",
			});

		// if (existingUser) {
		// 	if (!isMobile) {
		// 		//send email otp
		// 		res
		// 			.status(201)
		// 			.json({ msg: "User Registerd, Enter OTP sent to registered email" });
		// 	} else {
		// 		res
		// 			.status(202)
		// 			.json({ msg: "User Registerd, Enter OTP sent to mobile" });
		// 	}
		// } else {
		// 	res.json(402).json({
		// 		msg: "User Not Registered, Enter OTP sent to mobile to get started",
		// 	});
		// }

		// console.log(typeof existingUser._id);
		// if (existingUser) {
		// 	res.status(401).json({
		// 		userId: existingUser._id.toHexString(),
		// 		msg: "User exists, Enter OTP now",
		// 	});
		// } else res.status(501).json({ msg: "User does not exist, Sign Up now" });
		// // if (existingUser) {
		// // 	res.status(401).json({ msg: "Mobile Number already registered" });
		// // } else res.status(501).json({ msg: "Mobile Not Registered, Sign Up Here" });
	} catch (error) {
		console.log(error.message);
		res.status(500).json({ error: error.message });
	}
};

const signUpUser = async (req, res) => {
	try {
		const { phone, otp, name, email } = req.body;
		const existingUser = await User.findOne({ email });
		if (existingUser) {
			return res
				.status(400)
				.json({ msg: "User with this Email already exists" });
		}
		const verifyPhoneRes = await client.verify.v2
			.services(TWILIO_SERVICE_SID)
			.verificationChecks.create({ to: `+91${phone}`, code: otp });

		if (
			verifyPhoneRes["valid"] === true &&
			verifyPhoneRes["status"] === "approved"
		) {
			let user = new User({ name, email, phone });
			user = await user.save();
			const token = jwt.sign({ id: user._id }, JWT, { expiresIn: "1hr" });
			return res.status(200).json({
				msg: "Logged In Successfully",
				user: user,
				token: token,
			});
		}
		return res.status(400).json({ msg: "Incorrect OTP, Please Try Again" });
	} catch (error) {
		return res.status(500).json({ error: error.message });
	}
};

const verifyPhone = async (req, res) => {
	try {
		const { phone, otp } = req.body;
		const verifyPhoneRes = await client.verify.v2
			.services(TWILIO_SERVICE_SID)
			.verificationChecks.create({ to: `+91${phone}`, code: otp });
		console.log(verifyPhoneRes);
		if (
			verifyPhoneRes["valid"] === true &&
			verifyPhoneRes["status"] === "approved"
		) {
			const user = await User.findOne({ phone: phone });
			const token = jwt.sign({ id: user._id }, JWT, { expiresIn: "1hr" });
			return res.status(200).json({
				msg: "OTP Correct, Mobile Number Verified",
				user: user,
				token: token,
			});
		}
		return res.status(400).json({ msg: "Incorrect OTP, Please Try Again" });
	} catch (error) {
		return res.status(500).json({ error: error.message });
	}
};

const getUser = async (req, res) => {
	const user = await User.findById(req.user);
	res.json({ msg: "User Details", user: user, token: req.token });
};

module.exports = { checkUser, signUpUser, verifyPhone, getUser };
