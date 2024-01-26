import { useCallback, useEffect, useState } from 'react';
import "./State.css";

import Box from '@mui/material/Box';
import FormHelperText from '@mui/material/FormHelperText';
import Divider from '@mui/material/Divider';
import ButtonGroup from '@mui/material/ButtonGroup';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';

function Status(props) {
  return (
    <div className="State">
      <Box m={2}>
        <h1>State</h1>

        <StateTimes gameState={props.gameState}/>
        <StateStats lassieData={props.lassieData} gameState={props.gameState}/>

        <Divider sx={{my: 2}} />

        <StateRounds gameState={props.gameState} updateCurrentLaunch={props.updateCurrentLaunch}/>
        <StateScenarios gameState={props.gameState} updateCurrentPhase={props.updateCurrentPhase}/>

        <Divider sx={{my: 2}} />

        <Button variant="outlined" color="error" onClick={props.resetGameState}>Reset game state</Button>
      </Box>
    </div>
  );
}

function StateRounds(props) {
  const initialRounds = [
    {
      number: 1,
      active: true,
    },
    {
      number: 2,
      active: false,
    },
    {
      number: 3,
      active: false,
    },
    {
      number: 4,
      active: false,
    },
    {
      number: 5,
      active: false,
    },
    {
      number: 6,
      active: false,
    },
    {
      number: 7,
      active: false,
    },
    {
      number: 8,
      active: false,
    },
    {
      number: 9,
      active: false,
    },
    {
      number: 10,
      active: false,
    },
  ];

  const [rounds, setRounds] = useState(initialRounds);

  const updateRounds = (number) => {
    let roundsTemp = [...rounds];
    roundsTemp.map((round) => {
      round.active = round.number == number;
    });
    setRounds(roundsTemp);
  }

  useEffect(() => {
    updateRounds(props.gameState.launch.launch)
  }, [props.gameState.launch])

  return (
    <div>
      <FormHelperText sx={{ fontWeight: 'bold' }}>Launches</FormHelperText>
      <ButtonGroup aria-label="outlined primary button group" fullWidth>
        {rounds.map((round) => 
          <Button variant={round.active ? "contained" : "outlined"} onClick={() => {
            props.updateCurrentLaunch(round.number)
            updateRounds(round.number);
          }}>{round.number}</Button>
        )}
      </ButtonGroup>
    </div>
  );
}

function StateScenarios(props) {
  const initialScenarios = [
    {
      name: "start",
      active: true,
    },
    {
      name: "build",
      active: false,
    },
    {
      name: "reveal",
      active: false,
    },
    {
      name: "countdown",
      active: false,
    },
    {
      name: "liftoff",
      active: false,
    },
    {
      name: "finalLiftoff",
      active: false,
    },
    {
      name: "debrief",
      active: false,
    },
  ];

  const [scenarios, setScenarios] = useState(initialScenarios);

  const updateScenarios = (name) => {
    let scenariosTemp = [...scenarios];
    scenariosTemp.map((scenario) => {
      scenario.active = scenario.name == name;
    });
    setScenarios(scenariosTemp);
  }

  useEffect(() => {
    updateScenarios(props.gameState.phase)
  }, [props.gameState.phase])

  return (
    <div>
      <FormHelperText sx={{ fontWeight: 'bold' }}>Phases</FormHelperText>
      <ButtonGroup variant="outlined" aria-label="outlined primary button group" fullWidth>
        {scenarios.map((scenario) => 
          <Button variant={scenario.active ? "contained" : "outlined"} onClick={() => {
            props.updateCurrentPhase(scenario.name)
            updateScenarios(scenario.name);
          }}>{scenario.name}</Button>
        )}
      </ButtonGroup>
    </div>
  );
}

function StateTimes(props) {
  const [absoluteTime, setAbsoluteTime] = useState("00:00:00");
  const [relativeTime, setRelativeTime] = useState("T - 0:00:00");

  const calculateRelativeTime = useCallback((launchDate) => {
    let sec = Math.ceil((new Date(launchDate) - new Date()) / 1000);
    let secAbs = Math.abs(sec);
    return `T ${sec < 0 ? '+' : '-'} ${Math.floor(secAbs / (60 * 60))}:${prettyNumber(Math.floor(secAbs % (60 * 60) / 60))}:${prettyNumber(secAbs % 60)}`;
  }, []);

  useEffect(() => {
    const interval = setInterval(() => {
      setAbsoluteTime(new Date().toLocaleTimeString());
      setRelativeTime(calculateRelativeTime(props.gameState.launch.date));
    }, 1000);

    return () => { clearInterval(interval) };
  }, [props.gameState.launch.date, calculateRelativeTime]);

  const prettyNumber = (number) => {
    return number < 10 ? "0" + number : number;
  }

  return (
    <Stack spacing={2} direction="row">
      <div className="text-left width-33">
        <FormHelperText sx={{ fontWeight: 'bold' }}>Absolute time</FormHelperText>
        <p className="single-stat-value">{absoluteTime}</p>
      </div>

      <div className="text-center width-33">
        <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'center' }}>Relative time</FormHelperText>
        <p className="single-stat-value">{relativeTime}</p>
      </div>

      <div className="text-right width-33">
        <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'right' }}>Next launch</FormHelperText>
        <p className="single-stat-value">{new Date(props.gameState.launch.date).toLocaleTimeString()}</p>
      </div>
    </Stack>
  );
}

function StateStats(props) {

  let totalPeople = 0;
  let totalBeers = 0;
  let totalSodas = 0;
  if(props.lassieData !== undefined){
    for (const key in props.lassieData.perColor){
      totalPeople = totalPeople + props.lassieData.perColor[key]
      totalBeers = totalBeers + props.gameState.totalDrinks.beer[key]
      totalSodas = totalSodas + props.gameState.totalDrinks.soda[key]
  
    }
  }
  
  return (
    <div className="StateStats">
      <Stack spacing={2} direction="row">
        <div className="text-left width-33">
          <FormHelperText sx={{ fontWeight: 'bold' }}>People</FormHelperText>
          <p className="single-stat-value">{totalPeople}</p>
        </div>

        <div className="text-center width-33">
          <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'center' }}>Beers</FormHelperText>
          <p className="single-stat-value">{totalBeers}</p>
        </div>

        <div className="text-right width-33">
          <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'right' }}>Sodas</FormHelperText>
          <p className="single-stat-value">{totalSodas}</p>
        </div>
      </Stack>
    </div>
  );
}

export default Status;
