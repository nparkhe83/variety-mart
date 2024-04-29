import express from "express";
import { gracefulShutdownHandler } from "./gracefulShudownHandler";

const app = express();

app.get("/kill", () => {
  process.kill(process.pid, "SIGINT");
});

app.get("/terminate", () => {
  process.kill(process.pid, "SIGTERM");
});

app.get("/", (req, res) => {
  res.send("Hello from App Engine");
});

const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, () => {
  console.log(`App is listening on port ${PORT}`);
});

process.on("SIGINT", handleSignal);
process.on("SIGTERM", handleSignal);

function handleSignal(signal: "SIGINT" | "SIGTERM" | "SIGKILL") {
  gracefulShutdownHandler(server, signal);
}
