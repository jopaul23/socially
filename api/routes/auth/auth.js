const router = require("express").Router();
const bycrpt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../../models/user");

const Joi = require("@hapi/joi");

const registerSchema = Joi.object({
  name: Joi.string().required(),
  email: Joi.string().required().email(),
  password: Joi.string().required(),
});

router.post("/register", async (req, res) => {
  console.log(req.body);
  const emailExists = await User.findOne({ email: req.body.email });

  if (emailExists) {
    res.status(400).send({message : "email already exists"});
    return;
  }

  const salt = await bycrpt.genSalt(10);
  const hashedPassword = await bycrpt.hash(req.body.password, salt);

  const user = new User({
    name: req.body.name,
    password: hashedPassword,
    email: req.body.email,
    posts: [],
  });

  try {
    const { error } = await registerSchema.validateAsync(req.body);

    if (error) {
      res.status(400).send({message : error.details[0].message});
      return;
    } else {
      const savedUser = await user.save();
      const token = jwt.sign({ _id: savedUser._id }, process.env.TOKEN_SECRET);
      res.status(200).header("auth-token", token).send({
        message: "user created",
        token: token,
        id: savedUser.id,
        name: savedUser.name,
        email: savedUser.email,
        
      });
    }
  } catch (error) {
    res.status(500).send(error);
  }
});

const loginShema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required(),
});

router.post("/login", async (req, res) => {
  console.log(req.body)
  const fetchedUser = await User.findOne({ email: req.body.email });

  if (!fetchedUser) {
    return res.status(400).send({message:"email not registered"});
  }

  const validPassword = await bycrpt.compare(
    req.body.password,
    fetchedUser.password
  );
  if (!validPassword) {
    return res.status(400).send({message:"incorrect password"});
  }

  try {
    const { error } = await loginShema.validateAsync(req.body);
    if (error) return res.status(400).send({"message":error.details[0].message});
    else {
      const token = jwt.sign(
        { _id: fetchedUser._id },
        process.env.TOKEN_SECRET
      );
      res.header("auth-token", token).send({
          token : token,
          email : fetchedUser.email,
          id: fetchedUser.id,
          name:fetchedUser.name,
          message :"login successfull"
      }).status(200);
    }
  } catch (error) {
    res.status(500).send(error);
  }
});


router.post("/get", async (req, res) => {
  try {
    const result = await User.findById({_id:req.body._id})
      .catch((err) => {
        console.log(err);
      });
    return res.json(result).status(200);
  } catch (error) {
    console.log(error);
  }
  return res.send({"message":"failed"}).status(500)
});


router.post('/update-profile',(req,res)=>{
  User.findByIdAndUpdate(
    { _id: req.body.id },
    { $set: { profile: req.body.profile_url } },
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
})
module.exports = router;
