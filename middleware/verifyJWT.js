const { verify } = require("jsonwebtoken");
require("dotenv").config();

const verifyJWT = (req, res, next) => {
  //console.log("reqs = ", req);
  const authHeader = req.headers["authorization"];
  if (!authHeader) return res.status(403).json({message:"UnAuthorized token"});
  console.log("Auth Header = ",authHeader); // Bearer token
  const token = authHeader.split(" ")[1];
  verify(token, process.env.ACCESS_TOKEN_SECRET, (err, decoded) => {
   
      if (err) {
       return res.status(401).json({ message: "Forbidden: Invalid token detected" });
      } else {
          console.log('Decoded JWT token:', decoded.userDet);
          req.user = decoded.userDet;
          next();
      }
  });
}

module.exports = verifyJWT;