const mongoose = require('mongoose')

const userSchema = mongoose.Schema({
    name : {
        type :String,
        min :1,
        max : 255,
        required : [true,"name required"]
    },
    email : {
        type :String,
        required: [true,"email required"],
        min :10,
        max : 255,
    },
    password : {
        type :String,
        required: [true,"password required"],
        min :10,
        max : 255,
    },
    date : {
        type : Date,
        default  :Date.now(),
    },
    posts :[String]
});

module.exports = mongoose.model("User",userSchema)

