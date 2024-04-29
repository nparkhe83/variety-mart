import { Server } from "http";

export const gracefulShutdownHandler = function gracefulShutdownHandler(
  server: Server,
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
    shutdown(server);
  }, delay).unref();
};

function shutdown(server: any) {
  server.close(function () {
    console.log("👋 All requests stopped, shutting down");
    // once the server is not accepting connections, exit
    process.exit();
  });
}
