import express from "express";

const app = express();

app.get("/", (req, res) => {
  res.send("Hello from App Engine");
});

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
});
