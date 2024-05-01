import { Router } from "express";
import { debug } from "../utils/debug";

const submitRouter = Router();

submitRouter
  .get("/submit", (req, res) => {
    res.send("This is the submit route");
  })
  .post("/submit", (req, res) => {
    debug("Reques Object: ", req);
    console.log({
      name: req.body.name,
      message: req.body.message,
    });
    res.send("Thanks for your message!");
  });

export { submitRouter };
