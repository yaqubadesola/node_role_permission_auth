const express = require('express');
const userController = require('../controllers/userController');
const verifyToken = require('../middleware/verifyJWT');
const userRouter = express.Router();
userRouter.post('/register', userController.signUp)
userRouter.post('/login', userController.userLogin)
userRouter.get('/refresh', userController.getRefreshToken)
userRouter.post('/logout', verifyToken, userController.logoutUser)
module.exports = userRouter