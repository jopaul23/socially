const express = require("express");
const app = express();
const dotenv = require("dotenv");

const PORT = process.env.PORT || 4050;

app.get("/", (req, res) => {
  res.send(`Hey it's working !!`);
});
app.listen(PORT, () => console.log(`server up and running at  ${PORT}`));

const mongoose = require("mongoose");
const cors = require("cors");

const authRoute = require("./routes/auth/auth");
const authDashboard = require("./routes/auth/authDashboard");
const postsRoute = require("./routes/posts/post");

dotenv.config();

mongoose.connect(
  process.env.DB_CONNECT,
  {
    useCreateIndex: true,
    useFindAndModify: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    autoIndex: true,
  },
  () => console.log("connected to db")
);

app.use(express.json(), cors());

app.use("/api/users", authRoute);
app.use("/api/posts", postsRoute);
app.use("/api/dashboard", authDashboard);

