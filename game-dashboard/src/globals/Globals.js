import { useState } from "react";
import "./Globals.css";
  
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';
import FormHelperText from '@mui/material/FormHelperText';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';

function Globals(props) {
  const [multiplierGlobal, setMultiplierGlobal] = useState();
  const [multiplierSoda, setMultiplierSoda] = useState();
  const [oldestMember, setOldestMember] = useState();

  return (
    <div className="Globals">
      <Box m={2}>
        <h1>Globals</h1>


        <div className="team-stats">
          <Stack spacing={2} direction="row">
            <div className="text-left width-50">
              <FormHelperText sx={{ fontWeight: 'bold' }}>Multiplier global</FormHelperText>
              <p className="single-stat-value">{props.gameState.globalMultiplier}</p>

              <FormHelperText sx={{ fontWeight: 'bold'}}>Oldest member</FormHelperText>
              <p className="single-stat-value">{props.gameState.oldestMember.name + "," + props.gameState.oldestMember.team + "," + props.gameState.oldestMember.generation}</p>
            </div>

            <div className="width-50">
              <FormHelperText sx={{ fontWeight: 'bold' }}>Multiplier soda</FormHelperText>
              <p className="single-stat-value">{props.gameState.sodaMultiplier}</p>
            </div>
          </Stack>
        </div>

        <Divider sx={{my: 2}} />

        <Stack spacing={2} direction="row">
          <div className="width-50">
            <div>
              <FormHelperText sx={{ fontWeight: 'bold' }}>Multiplier global</FormHelperText>
              <Stack spacing={2} direction="row">
                <input
                  type="tel"
                  placeholder={props.gameState.globalMultiplier}
                  value={multiplierGlobal}
                  onChange={(e) => {
                    const val = e.target.value;
                    if (e.target.validity.valid) {
                      setMultiplierGlobal(e.target.value);
                    } else if (val === "" || val === "-") {
                      setMultiplierGlobal(val);
                    }
                  }}
                  pattern="^-?[0-9]\d*\.?\d*$"
                ></input>
                <Button variant="outlined"
                  onClick={() => {
                    setMultiplierGlobal("");
                    props.updateGlobalMultiplier(multiplierGlobal);
                  }}
                >
                  Update
                </Button>
              </Stack>
            </div>
            <div>
              <FormHelperText sx={{ fontWeight: 'bold' }}>Oldest member</FormHelperText>
              <Stack spacing={2} direction="row">
                <input
                  type="tel"
                  placeholder={props.gameState.oldestMember.name + "," + props.gameState.oldestMember.team + "," + props.gameState.oldestMember.generation}
                  value={typeof oldestMember !== "object" ? oldestMember : Object.values(oldestMember).join(',')}
                  onChange={(e) => {
                    const val = e.target.value;
                    if (e.target.validity.valid) {
                      setOldestMember(e.target.value);
                    } else if (val === "" || val === "-") {
                      setOldestMember(val);
                    }
                  }}
                ></input>
                <Button variant="outlined"
                  onClick={() => {
                    setOldestMember("");
                    props.updateOldestMember(oldestMember);
                  }}
                >
                  Update
                </Button>
              </Stack>
            </div>
          </div>

          <div className="width-50">
            <div>
              <FormHelperText sx={{ fontWeight: 'bold' }}>Multiplier soda</FormHelperText>
              <Stack spacing={2} direction="row">
                <input
                  type="tel"
                  placeholder={props.gameState.sodaMultiplier}
                  value={multiplierSoda}
                  onChange={(e) => {
                    const val = e.target.value;
                    if (e.target.validity.valid) {
                      setMultiplierSoda(e.target.value);
                    } else if (val === "" || val === "-") {
                      setMultiplierSoda(val);
                    }
                  }}
                  pattern="^-?[0-9]\d*\.?\d*$"
                ></input>
                <Button variant="outlined"
                  onClick={() => {
                    setMultiplierSoda("");
                    props.updateSodaMultiplier(multiplierSoda);
                  }}
                >
                  Update
                </Button>
              </Stack>
            </div>
          </div>
        </Stack>

        <Divider sx={{my: 2}} />

        <div className={props.connectionStatus ? 'text-green' : 'text-red'}>
          MQTT {props.connectionStatus ? 'connected' : 'not connected'}
        </div>
      </Box>
    </div>
  );
}

export default Globals;
