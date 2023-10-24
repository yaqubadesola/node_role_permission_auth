const express = require('express')
const cors = require('cors');
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const verifyToken = require('./middleware/verifyJWT')
const postRouter = require('./routes/posts')
const userRouter = require('./routes/users')

require('dotenv').config();
const app = express();
app.use(cors({
    origin: 'http://localhost:3003', // Replace with your React frontend URL and port
  }));
app.use(bodyParser.json());
app.use(cookieParser())
app.use("/auth",userRouter)
app.use(verifyToken)
app.use("/posts",postRouter)

module.exports = app