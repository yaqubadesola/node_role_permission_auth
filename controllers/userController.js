const db = require('../models')
const Validator = require('fastest-validator')
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = db.User
const Permission = db.Permission
const Role = db.Role;

const signUp = async (req, res) => {
    try {
        const saltRounds = 10;
         bcrypt.hash(req.body.password,saltRounds, (err, hash) => {
            if (err) {
                console.error('Error hashing password:', err);
                // Handle the error
                return  res.status(500).json({ error:err.message});
            } else {
                const userObj = {
                    name: req.body.name,
                    password: hash,
                    email: req.body.email,
                    roleId: req.body.roleId
                }
                User.create(userObj).then(result => {
                        res.status(201).json(result);
                }).catch(err => {
                    console.log('Error:', err)
                    res.status(500).json({ error:err.message})
                })
                
            }
        })   
    } catch (error) {
        if (error.name === 'SequelizeValidationError') {
            // Handle validation error
            const errors = error.errors.map(err => err.message);
            res.status(400).json(errors);
        } else {
            // Handle other errors
            res.status(500).json(error.message);
        }
    }
}

const userLogin = async (req, res) => {
  console.log(req.body);
  const { email, password } = req.body;
  if (!email || !password)
    return res
      .status(400)
      .json({ message: "Username and password are required." });
    //const foundUser = usersDB.users.find((person) => person.username === user);
  const foundUser = await User.findOne({where:{email: req.body.email},
    include: [
    {
      model: Role, 
    },
  ]})
  //const rolePermission = foundUser.Role.RolePermission
  //console.log("User Role = ", foundUser.Role);
  const userAllPermissions = await foundUser.Role.getUserPermissions();
  const perms = userAllPermissions? userAllPermissions.map(permission => permission.perm_name) : "";
  //console.log("User is here = ", foundUser)
  if (!foundUser) return res.status(401).json({message:"Unauthorized! Username/Password is invalid"}); //Unauthorized
  // evaluate password
  const match = await bcrypt.compare(password, foundUser.password);
  if (match) {
    // create JWTs
    //remove password and refresh token
    const {id, name, email, roleId, Role }  = foundUser
    const jwtUserProfile = {
      id, name, email, roleId, Role, permissions : perms
    }
   console.log("jwtUserProfile created", jwtUserProfile)
    const accessToken = jwt.sign(
      { userDet: jwtUserProfile },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "1h" }
      )
      
    const refreshToken = jwt.sign(
      { userDet: jwtUserProfile },
      process.env.REFRESH_TOKEN_SECRET,
      { expiresIn: "1d" }
    )
    // console.log("Generated token:", accessToken);
    // console.log("Generated Refresh Token :", refreshToken);

    //Saving refresh tokens with current user
      
      const updateRec = {
          refreshToken: refreshToken,
          name: foundUser.name,
          email: foundUser.email
          
      }
     // res.json({ success: `User ${user} is logged in!` });
    
    const updateRes = User.update(updateRec, { where:{id:foundUser.id}})
    if(updateRes){
         res.cookie("jwt", refreshToken, {
            httpOnly: true,
            sameSite: "None",
            secure: false,
            maxAge: 24 * 60 * 60 * 1000,
        });
    } else {
        return res.status(403).send({message:"Unable to generate refresh token"})
    }
   
    res.status(200).json({ accessToken });
  } else {
    res.status(401).json({message:"Unauthorized"});
  }       
}

const getRefreshToken = async (req, res) => {
  const cookies = req.cookies;
  console.log("cookies = ", cookies);
  if (!cookies?.jwt) return res.status(401).json("Something went wrong");
  const refreshToken = cookies.jwt;
    console.log("cookie reftoken user", refreshToken);
    const refreshTokenDB = await User.findOne({where:{refreshToken: refreshToken}})
  console.log("User DB reftoken user found", refreshTokenDB);
 
  //console.log("Found user", foundUser);
  if (!refreshTokenDB) return res.status(403).json({message:"Token not found"}); //Forbidden
  // evaluate jwt
  jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, decoded) => {
    if (err || refreshTokenDB.username !== decoded.username)
      return res.status(403).json({message:"Invalid Refresh Token found"}); 
    const accessToken = jwt.sign(
      { username: decoded.username },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "30s" }
    );
    res.json({ accessToken });
  });
};

module.exports = {
    signUp,
    userLogin,
    getRefreshToken
}