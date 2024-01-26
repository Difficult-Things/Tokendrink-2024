import chokidar from "chokidar";
import csv from "csvtojson";

import fs from "fs";
import path from "path";

var argv = require("minimist")(process.argv.slice(2));

// Path to watch
const DEFAULT_PATH = path.join(process.cwd(), "tokendrink-pubcard-data");
const pathToWatch = argv.path || DEFAULT_PATH;

// Check if path is specified
if (!argv.path) {
  console.log("No path specified, using default: ", DEFAULT_PATH);
}

// Clean data folder
if (fs.existsSync(pathToWatch)) {
  console.log("Cleaning data folder...");
  if (argv.clean) fs.rmSync(pathToWatch, { recursive: true });
}
fs.mkdirSync(pathToWatch, { recursive: true });

// Start watcher
console.log("Starting watcher...");
const watcher = chokidar.watch(pathToWatch, {
  persistent: true,
});

// On Watcher ready
watcher.on("ready", () => {
  console.log("Ready to watch for changes!");
  console.log("Monitoring path: ", pathToWatch);
});

// On file added
watcher.on("add", async (path) => {
  const time = new Date().toLocaleTimeString();
  console.log(`${time}: File ${path} has been added.`);

  try {
    const json = await csv().fromFile(path);
    // Handle data to game server
  } catch (err) {
    console.error(err);
  }
});
