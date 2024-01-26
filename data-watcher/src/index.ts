import chokidar from "chokidar";
import csv from "csvtojson";

import fs from "fs";
import path from "path";

var argv = require("minimist")(process.argv.slice(2));
console.dir(argv);

const DEFAULT_PATH = path.join(process.cwd(), "tokendrink-pubcard-data");
const pathToWatch = argv.path || DEFAULT_PATH;

if (!argv.path) {
  console.log("No path specified, using default: ", DEFAULT_PATH);
}

if (argv.clean) {
  console.log("Cleaning data folder...");

  if (fs.existsSync(pathToWatch)) fs.rmSync(pathToWatch, { recursive: true });
  fs.mkdirSync(pathToWatch);
}

console.log("Starting watcher...");
const watcher = chokidar.watch(pathToWatch, {
  persistent: true,
});

watcher.on("ready", () => {
  console.log("Ready to watch for changes!");
  console.log("Monitoring path: ", pathToWatch);
});

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
