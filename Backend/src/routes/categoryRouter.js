const express = require("express");
const router = express.Router();

const Category = require("../models/category");

router.post("/list", async function (req, res) {
  var categories = await Category.find({ userid: req.body.userid });
  res.json(categories);
});

router.post("/add", async function (req, res) {
  await Category.deleteOne({ id: req.body.id });

  const newCategory = Category({
    id: req.body.id,
    userid: req.body.userid,
    title: req.body.title,
    icon: req.body.icon,
  });
  await newCategory.save();
  const response = {
    message: "Category created successfully!" + `id: ${req.body.id}`,
  };

  res.json(response);
});

router.post("/delete", async function (req, res) {
  await Category.deleteOne({ id: req.body.id });

  const response = {
    message: "Category deleted successfully! " + `id: ${req.body.id}`,
  };
  res.json(response);
});

module.exports = router;
