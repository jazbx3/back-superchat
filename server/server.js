import express from "express";
import { config } from "dotenv";

// Enable .env vars.
config();

const app = express();
const port = process.env.APP_PORT ? process.env.APP_PORT : 3000;

app.get("/", (req, res) => {
  res.status(200).send({
    msg: "Works!",
  });
});

app.listen(port, () => {
  console.log(
    `App ${process.env.APP_NAME} listening at http://localhost:${port}`
  );
});
