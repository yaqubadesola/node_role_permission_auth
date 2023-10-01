const db = require('../models');// '../models'
const Validator = require("fastest-validator");
const Post = db.Post;
const User = db.User;

const createPost = (req, res) => {
    //console.log("reqsuser = ", req.user)
    const post = {
        title: req.body.title,
        content: req.body.content,
        imageUrl: req.body.imageUrl,
        categoryId: req.body.categoryId,
        userId:req.user.id
    }
   
    const schema = {
        title: { type: "string", optional: false, max: 10 },
        content: { type: "string", min: 20, max: 255 },
    };

    const v = new Validator();
    const validateResponse = v.validate(post, schema);

    if (validateResponse !== true) {
        return res.status(400).json({ message:"Validation Errors",errors:validateResponse })
    }
    console.log("Post to create ", post)
    Post.create(post).then((result) => {
        res.status(201).json({
            message: "post created successfuly",
            post: result
        })
    }).catch((error) => {
         res.status(500).json({
            message: "Something went wrong",
            error: error
        })
    })
}


const index = async (req, res) => {
    try {
        const posts = await Post.findAll()
        if (res.status(200) && posts) {
            res.status(200).json(posts)
        } else {
            res.send({message:"Error fetching posts"})
        }
    } catch (error) {
        console.log("error = ", error)
        res.status(500).json({
            message: "Something went wrong",
            error: error
        })
    }
}

const singlePost = async (req, res) => {
    console.log("reqs body = ", req.params);
    const id = req.params.id
    try {
        const rec = await Post.findByPk(id)
        if (res.status(200) && rec) {
            res.status(200).json(result)
        } else {
            res.send({message: "No available post"})
        }
    } catch (error) {
        res.status(500).json({message: error.message})
    }
    // res.send(post)
}


const update = (req, res) => {
    console.log("reqs body = ", req.params);
    const id = req.params.id

    Post.update(req.body, { where:{id:id}}).then(
        num => {
            if (num == 1) {
                 res.send({message:"Record updated successfully"})
            } else {
                 res.send({message:"Record failed to update successfully"})
            }
           
        }
    ).catch(error => {
        res.status(500).json({message: "Something went wrong"})
    })

    // res.send(post)
}

const destroy = (req, res) => {
    //console.log("reqs body = ", req.params);
    const id = req.params.id

    Post.destroy({ where:{id:id}}).then(
        result => {
            if (res.status(200)) {
                 res.send({message:"Record deleted successfully"})
            } else {
                 res.send({message:"Record failed to update successfully"})
            }
           
        }
    ).catch(error => {
        res.status(500).json({message: "Something went wrong - could not beleted"})
    })

    // res.send(post)
}

module.exports = {
    createPost: createPost,
    index: index,
    singlePost: singlePost,
    update: update,
    destroy:destroy
}
