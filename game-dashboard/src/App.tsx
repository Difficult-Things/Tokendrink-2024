import { Buffer } from "buffer";
import logo from "./logo.svg";
import "./App.css";
import Team from "./Teams/Team";
import { useEffect, useState, useCallback, useRef } from "react";
import React from "react";
import Events from "./events/Events";
import Globals from "./globals/Globals";
import Status from "./state/State";
import {
  AdjustScoreEvent,
  AdjustTeamMultiplier,
  AdjustGlobalMultiplier,
  AdjustSodaMultiplier,
  SetCurrentPhase,
  SetCurrentLaunch,
  SetGameState,
  RetrieveStateEvent,
  SetRocketMapping,
  SetOldestMember,
  SetDefaultGameState,
} from "../../specifications/StateInput";
import { State } from "../../specifications/StateOutput";
import { CheckinsLassieEvent, LassieState } from "../../specifications/LassieOutput";
import mqtt from "mqtt/dist/mqtt";
import { Client } from 'mqtt';
import _ from 'lodash';
import { MQTT_PASSWORD, MQTT_USERNAME } from '../../specifications/Common.ts';
import { TeamColors } from "../../specifications/Common";
// import { useCookies } from 'react-cookie';
function App(): any {
  const [connectionStatus, setConnectionStatus] = React.useState(false);
  const [messages, setMessages] = React.useState([]);
  const [messageHistory, setMessageHistory] = useState([]);
  // const [cookies, setCookie] = useCookies(['gameStateHistory']);

  const [historyLocalStorage, setHistoryLocalStorage] = useState()


  const [gameState, setGameState] = useState<State>({
    launch: {
      date: new Date(),
      launch: 1,
      type: "regular",
    },
    phase: "start",
    rocketLevels: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 },
    launches: [],
    teamMultipliers: { red: 1, green: 1, blue: 1, orange: 1, purple: 1 },
    globalMultiplier: 1,
    sodaMultiplier: 1,
    rankingToRocketLevel: [],
    scores: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 },
    totalDrinks: { beer: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 }, soda: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 } },
    ranking: [],
    previousRound: {},
    oldestMember: { name: "John Doe", team: "red", generation: 2005 }
  });
  const [gameStateHistory, setGameStateHistory] = useState([])
  const [lassieState, setLassieState] = useState<LassieState>({
    beer: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 },
    soda: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 },
  });
  const client = useRef<Client | null>(null);

 

  const [lassieData, setLassieData] = useState<CheckinsLassieEvent>({
    name: "lassieCheckins",
    perColor: { red: 0, green: 0, blue: 0, orange: 0, purple: 0 },
    perGeneration: {},
  });

  useEffect(() => {
    client.current = mqtt.connect("ws://localhost:8888", { 
      username: MQTT_USERNAME,
      password: MQTT_PASSWORD,
    }) as Client;

    client.current?.on("connect", () => {
      setConnectionStatus(true);
      client.current?.subscribe("/state/output");
      client.current?.subscribe("/lassie/output");
    });
    client.current?.on("message", (topic, payload, packet) => {
      let inputString = new TextDecoder().decode(payload);
      let incomingObject = JSON.parse(inputString);
      console.log(incomingObject);

      if (topic === "/state/output") {
        if (incomingObject.hasOwnProperty("launch")) {

          setGameState(incomingObject);
        }
      } else if (topic === "/lassie/output") {
        if (incomingObject.hasOwnProperty("name")) {
          if (incomingObject.name === "lassieCheckins") {
            setLassieData(incomingObject);
          } else if (incomingObject.name === "lassieGlobal") {
            setLassieState(incomingObject.state);
          }
        }
      }
    });

    let object: RetrieveStateEvent = {
      name: "retrieveState",
    };
    sendMessage(JSON.stringify(object));
    return () => {
      client.current?.end();
    };

    
  }, []);

  const sendMessage = (message) => {
    client.current?.publish("/state/input", message);
  };

  useEffect(() => {
    let items = JSON.parse(localStorage.getItem('gameStateHistory'));
    console.log("ITEMS: ", items)
    if (items) {
      setHistoryLocalStorage(items);
    }
  }, [])

  useEffect(() => {
    if(historyLocalStorage !== undefined){
      let temp = [...historyLocalStorage, ...gameStateHistory]
      setGameStateHistory(temp)
    }

  }, [historyLocalStorage])

useEffect(() => {

  let historyCopy = [...gameStateHistory]

  if(gameState.hasOwnProperty("_state_retrieved")){
      historyCopy.push(gameState)
      while(historyCopy.length > 20){
        historyCopy.shift()
      }
  }

  setGameStateHistory(historyCopy)
}, [gameState])

useEffect(() => {
  if(gameStateHistory.length > 3){
    localStorage.setItem('gameStateHistory', JSON.stringify(gameStateHistory));
  }
}, [gameStateHistory])
  

  //TODO: tweaken van score to rocket level
  const changeRocketLevel = (array) => {
    let object: SetRocketMapping = {
      name: "setRocketMapping",
      payload: array,
    };
    sendMessage(JSON.stringify(object));
  };

  const updateGameState = (incomingGameState) => {
console.log(incomingGameState)
    let gameStateUpdate : State = {
      launch: incomingGameState.launch,
      phase: incomingGameState.phase,
      rocketLevels: incomingGameState.rocketLevels,
      launches: incomingGameState.launches,
      teamMultipliers: incomingGameState.teamMultipliers,
      globalMultiplier: incomingGameState.globalMultiplier,
      sodaMultiplier: incomingGameState.sodaMultiplier,
      rankingToRocketLevel: incomingGameState.rankingToRocketLevel,
      scores: incomingGameState.scores,
      totalDrinks: incomingGameState.totalDrinks,
      ranking: incomingGameState.ranking,
      previousRound: incomingGameState.previousRound
    }

    let object: SetGameState = {
      name: "setGameState",
      payload: gameStateUpdate,
    };
    sendMessage(JSON.stringify(object));
  };

  const updateCurrentLaunch = (number) => {
    let object: SetCurrentLaunch = {
      name: "setCurrentLaunch",
      payload: {
        launch: parseInt(number),
      },
    };
    sendMessage(JSON.stringify(object));
  };

  const updateCurrentPhase = (phase) => {
    let gameStateCopy = { ...gameState };
    gameStateCopy.phase = phase;
    setGameState(gameState);
    let object: SetCurrentPhase = {
      name: "setCurrentPhase",
      payload: {
        phase: phase,
      },
    };
    sendMessage(JSON.stringify(object));
  };

  const updateSodaMultiplier = (sodaMultiplier) => {
    let object: AdjustSodaMultiplier = {
      name: "adjustSodaMultiplier",
      payload: {
        sodaMultiplier: parseFloat(sodaMultiplier),
      },
    };
    sendMessage(JSON.stringify(object));
  };

  const updateMultiplier = (multiplier, teamColors) => {
    let object: AdjustTeamMultiplier = {
      name: "adjustTeamMultiplier",
      payload: {
        teamMultiplier: parseFloat(multiplier),
        teams: teamColors,
      },
    };
    console.log(object);
    sendMessage(JSON.stringify(object));
  };

  const updateGlobalMultiplier = (multiplier) => {
    let object: AdjustGlobalMultiplier = {
      name: "adjustGlobalMultiplier",
      payload: {
        globalMultiplier: parseFloat(multiplier),
      },
    };
    sendMessage(JSON.stringify(object));
  };

  const updateOldestMember = (oldestMember) => {
    console.log("oldestMember", oldestMember);
    if (oldestMember === undefined) return;
    let oldestMemberArray = oldestMember.split(',');
    if (oldestMemberArray.length !== 3) return;
    let object: SetOldestMember = {
      name: "setOldestMember",
      payload: {
        name: oldestMemberArray[0] as string,
        team: oldestMemberArray[1] as TeamColors,
        generation: parseInt(oldestMemberArray[2])
      },
    };
    sendMessage(JSON.stringify(object));
  };

  const addScore = (deltaScore, teamColors) => {
    let object: AdjustScoreEvent = {
      name: "adjustScore",
      payload: {
        delta: parseInt(deltaScore),
        teams: teamColors,
      },
    };
    sendMessage(JSON.stringify(object));
  };

  const resetGameState = () => {
    if (window.confirm('Are you really sure you want to reset the game to the default gamestate? This will DELETE the current gamestate without beign able to retrieve it easily...')) {
      let object: SetDefaultGameState = {
        name: 'setDefaultGameState',
      }
      sendMessage(JSON.stringify(object));
    }
  }

  const teamsInfo: { color: string, generations: string[] }[] = [
    {
      color: "red",
      generations: ["2007", "2012", "2017", "2022"],
    },
    {
      color: "orange",
      generations: ["2003", "2008", "2013", "2018"],
    },
    {
      color: "green",
      generations: ["2004", "2009", "2014", "2019"],
    },
    {
      color: "purple",
      generations: ["2005", "2010", "2015", "2020"],
    },
    {
      color: "blue",
      generations: ["2006", "2011", "2016", "2021"],
    },
  ];
  let teamsDisplays: any = [];
  for (let i = 0; i < teamsInfo.length; i++) {
    let key = teamsInfo[i].color;
    let team = {
      color: key,
      generations: teamsInfo[i].generations,
      rank: gameState.ranking.findIndex((t) => t === key) + 1,
      multiplier: gameState.teamMultipliers[key],
      score: gameState.scores[key],
      level: gameState.rocketLevels[key],
      people: lassieData.perColor[key],
      beer: lassieState.beer[key],
      soda: lassieState.soda[key],
    };
    teamsDisplays.push(
      <div className="horizontal-divider">
        <Team team={team} updateMultiplier={updateMultiplier} addScore={addScore} />
      </div>
    );
  }

  return (
    
    <div className="App">
      <div className="vertical-divider">
        <div className="horizontal-divider">
          <Events updateGameState={updateGameState} gameStateHistory={gameStateHistory} gameState={gameState} changeRocketLevel={changeRocketLevel} />
        </div>
        <div className="horizontal-divider">
          <Globals gameState={gameState} updateSodaMultiplier={updateSodaMultiplier} updateGlobalMultiplier={updateGlobalMultiplier} updateOldestMember={updateOldestMember} connectionStatus={connectionStatus} />
        </div>
        <div className="horizontal-divider">
          <Status gameState={gameState} updateCurrentLaunch={updateCurrentLaunch} updateCurrentPhase={updateCurrentPhase} resetGameState={resetGameState} lassieData={lassieData} />
        </div>
      </div>
      <div className="vertical-divider">{teamsDisplays}</div>
    </div>
  );
}

export default App;
