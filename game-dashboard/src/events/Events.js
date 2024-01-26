import { useState, useEffect } from "react";
import "./Events.css";

import Box from "@mui/material/Box";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Select from "@mui/material/Select";
import Stack from "@mui/material/Stack";
import Button from "@mui/material/Button";
import Grid from "@mui/material/Grid";

function Events(props) {
  const [levelsState, setLevelsState] = useState([]);
  const [levelsStateCopy, setLevelsStateCopy] = useState([]);

  useEffect(() => {
    setLevelsState(props.gameState.rankingToRocketLevel);
    if (levelsStateCopy.length === 0) {
      setLevelsStateCopy(props.gameState.rankingToRocketLevel);
    }
  }, [props.gameState.rankingToRocketLevel]);

  const updateLevels = (roundIndex, levelIndex, value) => {
    let tempRanking = [...levelsStateCopy];
    if (value !== "") {
      tempRanking[roundIndex][levelIndex] = parseFloat(value);
    } else {
      tempRanking[roundIndex][levelIndex] = levelsState[roundIndex][levelIndex];
    }
    setLevelsStateCopy(tempRanking);
  };

  let rankings = [];
  if (levelsState !== undefined && levelsStateCopy !== undefined) {
    levelsState.map((round, roundIndex) => {
      rankings.push(
        <div className="round-levels">
          {" "}
          {roundIndex + 1}
          {levelsState[roundIndex].map((level, levelIndex) => {
            if (levelsState[roundIndex][levelIndex] === levelsStateCopy[roundIndex][levelIndex]) {
              return (
                <input
                  className="round-level-input"
                  value=""
                  placeholder={level}
                  onChange={(e) => {
                    updateLevels(roundIndex, levelIndex, e.target.value);
                  }}
                ></input>
              );
            } else {
              return (
                <input
                  className="round-level-input"
                  style={{ fontWeight: "bold" }}
                  value={levelsStateCopy[roundIndex][levelIndex]}
                  onChange={(e) => {
                    updateLevels(roundIndex, levelIndex, e.target.value);
                  }}
                ></input>
              );
            }
          })}
        </div>
      );
    });
  }

  return (
    <div className="Events">
      <Box m={2}>
        <h1>Levels</h1>
        {/* <EventsCustom /> */}
        {/* <EventsGrid /> */}
        <div className="level-container">{rankings}</div>

        <Button
          variant="contained"
          onClick={() => {
            props.changeRocketLevel(levelsStateCopy);
          }}
        >
          UPDATE LEVELS
        </Button>

        <Snapshots gameStateHistory={props.gameStateHistory} updateGameState={props.updateGameState} />
      </Box>
    </div>
  );
}

function Snapshots(props) {
  const [snapshot, setSnapshot] = useState(0);

  const handleChange = (event) => {
    setSnapshot(event.target.value);
  };

  return (
    <div className="EventsCustom" style={{ marginTop: "15px" }}>
      <Stack spacing={2} direction="row">
        <FormControl fullWidth>
          <InputLabel id="events-custom-label">Snapshots</InputLabel>
          <Select labelId="events-custom-label" id="events-custom-select" value={snapshot._state_retrieved} label="Snapshots" onChange={handleChange}>
            {props.gameStateHistory.map((history) => {
              let date = new Date();
              date.setTime(history._state_retrieved);
              return <MenuItem value={history}>
                <Stack spacing={4} direction='row'>
                  <p>
                    {date.getHours()}:{date.getMinutes()}:{date.getSeconds()}
                  </p>
                  <div className="text-right width-50">
                    <p>
                      Launch: {history.launch.launch}
                    </p>
                  </div>
                  <div className="text-right width-50">
                    <p>
                      Phase: {history.phase}
                    </p>
                  </div>
                </Stack>
                </MenuItem>;
            })}
          </Select>
        </FormControl>
        <Button variant="contained" onClick={() => props.updateGameState(snapshot)}>
          Send
        </Button>
      </Stack>
    </div>
  );
}

const customEvents = [
  {
    label: 'Select',
    value: 0
  },
  {
    label: 'Explosion',
    value: 1
  },
  {
    label: "Sound",
    value: 2,
  },
  {
    label: "Fire",
    value: 3,
  },
];

function EventsCustom() {
  const [customEvent, setCustomEvent] = useState(0);

  const handleChange = (event) => {
    setCustomEvent(event.target.value);
  };

  return (
    <div className="EventsCustom">
      <Stack spacing={2} direction="row">
        <FormControl fullWidth>
          <InputLabel id="events-custom-label">Custom event</InputLabel>
          <Select labelId="events-custom-label" id="events-custom-select" value={customEvent} label="Custom event" onChange={handleChange}>
            {customEvents.map((evt) => (
              <MenuItem value={evt.value}>{evt.label}</MenuItem>
            ))}
          </Select>
        </FormControl>
        <Button variant="contained">Send</Button>
      </Stack>
    </div>
  );
}

const gridEvents = [
  {
    label: "Explosion",
    value: 1,
    color: "blue",
  },
  {
    label: "Sound",
    value: 2,
    color: "green",
  },
  {
    label: "Fire",
    value: 3,
    color: "purple",
  },
];

function EventsGrid() {
  return (
    <div className="EventsGrid">
      <Box mt={3} sx={{ flexGrow: 1 }}>
        <Grid container spacing={2}>
          {gridEvents.map((evt) => (
            <Grid item xs={4}>
              <Button variant="outlined" color="primary" sx={{ padding: 4, borderColor: evt.color, color: evt.color, backgroundColor: "#fcfcfc" }}>
                {evt.label}
              </Button>
            </Grid>
          ))}
        </Grid>
      </Box>
    </div>
  );
}

export default Events;
