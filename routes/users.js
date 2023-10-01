const express = require('express');
const userController = require('../controllers/userController');
const userRouter = express.Router();
userRouter.post('/register', userController.signUp)
userRouter.post('/login', userController.userLogin)
userRouter.get('/refresh', userController.getRefreshToken)
module.exports = userRouter