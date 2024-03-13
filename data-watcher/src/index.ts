import chokidar from "chokidar";

import fs from "fs";
import path from "path";

import { PdfDocument } from "@ironsoftware/ironpdf";
import { Session } from "./util/session";

var argv = require("minimist")(process.argv.slice(2));

const session = new Session();

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

  // Check if filetype is pdf
  if (!path.endsWith(".pdf")) return;

  try {
    // Handle data to game server
    const pdf = await PdfDocument.fromFile(path);
    const text = await pdf.extractText();

    // fs.writeFileSync(path.replace(".pdf", ".txt"), text);

    session.processPDF(text);
    session.showData();

  } catch (err) {
    console.error(err);
  }
});
