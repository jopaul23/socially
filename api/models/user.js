const { number } = require('@hapi/joi');
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
    profile : {
        type : String,
        default  :"https://m.media-amazon.com/images/I/41jLBhDISxL._SY355_.jpg",
    },
    posts :[String]
});

module.exports = mongoose.model("User",userSchema)

