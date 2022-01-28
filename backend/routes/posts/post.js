const Joi = require("@hapi/joi");
const verify = require("../auth/authVerify");
const Posts = require("../../models/posts");
const User = require("../../models/user");
const router = require("express").Router();
const express = require("express");

const multer = require("multer");
const path = require("path");
const ejs = require("ejs");
const { appendFile } = require("fs");

const postSchema = Joi.object({
  caption: Joi.string(),
  owner_id: Joi.string().required(),
  owner_name: Joi.string().required(),
  owner_profile: Joi.string(),
});

// router.post('/add-post',verify,async (req,res)=>{
//     const post = new Posts({
//         caption : req.body.caption,
//         file_type : req.body.file_type,
//         file : req.body.file,
//         owner_id : req.body.owner_id,
//         owner_name : req.body.owner_name,
//         likes : [],
//         owner_profile: req.body.owner_profile
//     })

//     try{
//         const {error} =  await postSchema.validateAsync(req.body)
//         if(error) return res.status(400).send(error.details[0].message);
//         else{
//            const savedPost = await post.save()
//            User.findByIdAndUpdate({ _id:req.body.owner_id },{ $addToSet: { "posts": savedPost.id } },(err,result)=>{
//                if(err){
//                    return res.status(500).send({message :"error while updating",error:err.message})
//                }
//                else{
//                    return res.status(200).send({message:"successfully updated"})
//                }
//            })
//         }
//     }catch(error){
//         return res.status(500).send({message :"error while uploading",error:error.message})
//     }
// })

imageCount = 0;
//set storage engine
const storage = multer.diskStorage({
  destination: "./public/uploads/",
  filename: function (req, file, cb) {
    imageCount++;
    console.log(imageCount);
    cb(
      null,
      file.fieldname + "-" + imageCount + path.extname(file.originalname)
    );
  },
});

//check file type
function checkFiletype(file, cb) {
  const file_types = /jpeg|jpg|png|jfif/;
  console.log("file name", file.originalname);
  console.log("file", file);
  const extname = file_types.test(
    path.extname(file.originalname).toLowerCase()
  );

  const mimetype = file_types.test(file.mimetype);

  if (extname && file_types) {
    return cb(null, true);
  } else {
    cb("error : images only");
  }
}

//initialize upload
const upload = multer({
  storage: storage,
  limits: { fileSize: 2000000 },
  fileFilter: function (req, file, cb) {
    checkFiletype(file, cb);
  },
}).single("image");

router.post("/get", async (req, res) => {
  try {
    console.log(req.body)
    const result = await Posts.find(req.body)
      .sort({ publish_time: -1 })
      .limit(100)
      .catch((err) => {
        console.log(err);
      });
     res.json(result).status(200);
  } catch (error) {
    console.log(error);
  }
});

router.post("/upload-img", (req, res) => {
  upload(req, res, (err) => {
    if (err) {
      return res.send({ error: err });
    } else {
      console.log(req.file);
      const post = new Posts({
        caption: req.body.caption,
        file:
          req.file.fieldname +
          "-" +
          imageCount +
          path.extname(req.file.originalname),
        owner_id: req.body.owner_id,
        owner_name: req.body.owner_name,
        likes: [],
        owner_profile: req.body.owner_profile,
      });

      try {
        const { error } = postSchema.validateAsync(req.body);
        if (error) return res.status(400).send(error.details[0].message);
        else {
          post.save().then((value) => {
            User.findByIdAndUpdate(
              { _id: req.body.owner_id },
              { $addToSet: { posts: value.id } },
              (err, result) => {
                if (err) {
                  return res
                    .status(500)
                    .send({
                      message: "error while updating",
                      error: err.message,
                    });
                } else {
                  return res
                    .status(200)
                    .send({ message: "successfully updated" });
                }
              }
            );
          });
        }
      } catch (error) {
        return res
          .status(500)
          .send({ message: "error while uploading", error: error.message });
      }
    }
  });
});
router.use(express.static("public/uploads"));

// router.post('/get-image',(req,res)=>{
//     try{
//        return res.sendFile(req.body.image_path).status(200)
//     }catch(error){
//         return res.send(error).status(500)
//     }
// })

module.exports = router;
