const user = require("../../models/user")
const verify = require("./authVerify")

const router = require("express").Router()

router.get("/allUsers",verify,async (req,res)=>{
    try{
        const results =  await user.find().exec()
        res.send(results)
    }catch(error){
        res.status(500).send(error)
    }
})

module.exports =  router

