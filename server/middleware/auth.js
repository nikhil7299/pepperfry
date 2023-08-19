const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
	try {
		const token = req.header("x-auth-token");
		console.log(token);
		if (!token)
			return res.status(401).json({ msg: "No Auth Token, Access Denied" });
		const verified = jwt.verify(token, process.env.JWT_SECRET);

		if (!verified)
			return res.status(401).json({
				msg: "Token verification failed, Authorization Denied",
			});

		req.user = verified.id;
		req.token = token;
		next();
	} catch (error) {
		res.status(500).json({ error: error.message });
	}
};

module.exports = auth;
