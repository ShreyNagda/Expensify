const express = require("express");
const router = express.Router();

const Expense = require('../models/expense') 

router.get("/", function (req, res) {
  res.json({
    statusCode: res.statusCode,
    message: "API works!",
  });
});
router.post("/list", async function (req, res) {
    var expenses = await Expense.find({ userid: req.body.userid });
    res.json(expenses);
});

router.post("/add", async function (req, res) {
    await Expense.deleteOne({ id: req.body.id });

    const newExpense = Expense({
        id: req.body.id,
        userid: req.body.userid,
        amount: req.body.amount,
        description: req.body.description,
        category: req.body.category,
        date: req.body.date,
    });
    await newExpense.save();
    const response = {
        message: "Note created successfully!" + `id: ${req.body.id}`
    };

    res.json(response);
});
router.post("/delete", async function (req, res) {
    await Expense.deleteOne({ id: req.body.id });

    const response = {
        message: "Expenses deleted successfully! " + `id: ${req.body.id}`,
    };
    res.json(response);
});

module.exports = router;