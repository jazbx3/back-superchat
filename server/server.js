// Enable .env vars.
import './env/env'
import express from "express";

const app = express();
const port = process.env.APP_PORT ? process.env.APP_PORT : 3000;

app.get("/", (req, res) => {
  res.status(200).send({
    msg: "Works!"
  });
});

app.listen(port, () => {
  console.log(
    `App ${process.env.APP_NAME} listening at http://localhost:${port}`
  );
});
