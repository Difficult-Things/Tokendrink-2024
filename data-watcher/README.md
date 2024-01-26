# Data Watcher for Pubcard
This is a simple data watcher for the Tokendrink. It watches the data folder for changes and then updates the database accordingly so that exported data from the bar terminal can be automatically imported into the game server.

## Usage
To pass variables to the program, use the `--` flag and after that pass variables as normal. For example, to pass the `clean` flag, use `npm start -- --clean`.

To pass the data folder to watch, use the `--data-folder` flag. The default value is `./tokendrink-pubcard-data`.