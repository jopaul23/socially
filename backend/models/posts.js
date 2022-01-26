const mongoose  = require('mongoose')


const postSchema = mongoose.Schema({
    caption : {
        type : String,
        max : 2000    
    },
    file_type : {
        type : Number,//1-image ,2-video
        required : true,
    },
    file: {
        type : String,
    },
    like_count : {
        type :Number, 
    },
    likes : {
        type : [String],
    },
    owner_id : {
        type : String,
        required : true,
    },
    owner_name : {
        type : String,
        required : true,
    },
    owner_profile : {
        type:String,
    },
    publish_time : {
        type:Date,
        default: Date.now,
    },

})

module.exports =  mongoose.model("post",postSchema)

