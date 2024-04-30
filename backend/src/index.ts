import express from "express";
import { logger as pinoLogger } from "./logger_pino";
import { gracefulShutdownHandler } from "./gracefulShudownHandler";

const app = express();

app.get("/", (req, res) => {
  res.send("Hello from App Engine");
});

const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, () => {
  pinoLogger.warn("hello");
});

process.on("SIGINT", handleSignal);
process.on("SIGTERM", handleSignal);

function handleSignal(signal: "SIGINT" | "SIGTERM" | "SIGKILL") {
  gracefulShutdownHandler(server, signal);
}
