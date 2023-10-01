const { verify } = require("jsonwebtoken");
require("dotenv").config();
const verifyJWT = (req, res, next) => {
  //console.log("reqs = ", req);
  const authHeader = req.headers["authorization"];
  if (!authHeader) return res.status(401).json({message:"Authorized token"});
  //console.log(authHeader); // Bearer token
  const token = authHeader.split(" ")[1];
  verify(token, process.env.ACCESS_TOKEN_SECRET, (err, decoded) => {
   
      if (err) {
       return res.status(401).json({ message: "Invalid token detected" });
      } else {
          console.log('Decoded JWT token:', decoded.userDet);
          req.user = decoded.userDet;
          next();
      }
  });
}

module.exports = verifyJWT;