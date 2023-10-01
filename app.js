const express = require('express')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const verifyToken = require('./middleware/verifyJWT')
const postRouter = require('./routes/posts')
const userRouter = require('./routes/users')

require('dotenv').config();
const app = express();
app.use(bodyParser.json());
app.use(cookieParser())
app.use("/users",userRouter)
app.use(verifyToken)
app.use("/posts",postRouter)

module.exports = app