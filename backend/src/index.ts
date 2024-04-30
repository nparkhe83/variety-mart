import express from "express";
import { logger as pinoLogger } from "./logger_pino";
import { gracefulShutdownHandler } from "./gracefulShudownHandler";
import debugConstructor from "debug";
import requestID from "./request-id";
const debug = debugConstructor("app");

const app = express();

app.use(requestID());

app.get("/req-id", (req, res, next) => {
  res.send(req.id);
  next();
});

app.get("/", (req, res) => {
  res.send("Hello from App Engine");
});

const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, () => {
  pinoLogger.warn("hello");
  debug("Server started");
});

process.on("SIGINT", handleSignal);
process.on("SIGTERM", handleSignal);

function handleSignal(signal: "SIGINT" | "SIGTERM" | "SIGKILL") {
  gracefulShutdownHandler(server, signal);
}
