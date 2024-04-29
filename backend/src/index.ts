import express from "express";

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

const gracefulShutdownHandler = function gracefulShutdownHandler(
  signal: "SIGINT" | "SIGTERM" | "SIGKILL"
) {
  console.log(`⚠️ Received ${signal}, shutting down gracefully`);
  let delay = 10000;

  switch (signal) {
    case "SIGINT":
    case "SIGTERM":
      delay = 10000;
      break;
    case "SIGKILL":
      delay = 0;
      break;
  }

  setTimeout(() => {
    console.log("🤞 Shutting down application");
    shutdown();
  }, delay).unref();
};

function shutdown() {
  server.close(function () {
    console.log("👋 All requests stopped, shutting down");
    // once the server is not accepting connections, exit
    process.exit();
  });
}

process.on("SIGINT", gracefulShutdownHandler);
process.on("SIGTERM", gracefulShutdownHandler);
