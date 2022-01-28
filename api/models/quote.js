const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({

  email:{
      type:String,
      required : [true,"email required"],
      maxlength:100
  },
  otp : {
      type : Number,
      required : [true,"otp required"],
      maxlength : 6
  }
});

const model = mongoose.model("otpModel", otpSchema);

module.exports = model;