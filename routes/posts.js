const express = require('express');
const app = express();
const postController = require('../controllers/postController');
const postRouter = express.Router();
const checkRole = require('../middleware/checkRole');
const checkPermission = require('../middleware/checkPermission');
postRouter.get(
    '/', 
    checkPermission("canView"),
    postController.index
)
postRouter.get(
    '/:id', 
    checkPermission("canView"),
    postController.singlePost
)
postRouter.post(
    '/create',
    checkPermission("canSave"), 
    postController.createPost
)//
postRouter.delete('/:id', checkRole("admin"), postController.destroy)
postRouter.put('/:id', checkPermission("canEdit"), postController.update)

module.exports = postRouter