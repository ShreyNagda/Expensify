const express = require("express");
const app = express();

const mongoose = require("mongoose");

const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const databaseURL =
  "mongodb+srv://shreynagda:shrey0308@cluster0.zxdkj5v.mongodb.net/?retryWrites=true&w=majority";

mongoose.connect(databaseURL).then(function () {
  const expenseRouter = require("./routes/expenseRouter");
  const categoryRouter = require("./routes/categoryRouter");

  app.get("/", function (req, res) {
    res.json({
      statusCode: res.statusCode,
      message: "API works!",
    });
  });
  app.use("/expenses", expenseRouter);
  app.use("/categories", categoryRouter);
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, function () {
  console.log("Server listening at : " + PORT);
});
