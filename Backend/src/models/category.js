const mongoose = require("mongoose");

const categorySchema = mongoose.Schema({
  id: {
    type: String,
    unique: true,
    required: true,
  },
  userid: {
    type: String,
    default: "",
  },
  title: {
    type: String,
    required: true,
    unique: true,
  },
  icon: {
    type: Number,
    required: true,
  },
});
