import { useState } from "react";
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';
import FormHelperText from '@mui/material/FormHelperText';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';
import { Chip } from '@mui/material';

const Team = (props) => {
  const [multiplier, setMultiplier] = useState("");
  const [score, setScore] = useState("");

  return (
    <Box m={2}>
      <Stack direction="row" spacing={1} alignItems="center" justifyContent="center">
        <h2 className="team-heading">{props.team.color}</h2>
        <Chip size="small" label={props.team.rank} variant={props.team.rank === 1 ? 'filled' : 'outlined'} color={props.team.rank === 1 ? 'primary' : 'default'} />
      </Stack>
      <p>{props.team.generations.join(", ")}</p>

      <Divider sx={{my: 2, borderColor: props.team.color}} />

      <div className="team-stats">
        <Stack spacing={2} direction="row">
          <div className="text-left width-50">
            <FormHelperText sx={{ fontWeight: 'bold' }}>Level</FormHelperText>
            <p className="single-stat-value">{props.team.level}</p>

            <FormHelperText sx={{ fontWeight: 'bold' }}>People</FormHelperText>
            <p className="single-stat-value">{props.team.people}</p>

            <FormHelperText sx={{ fontWeight: 'bold' }}>Beers</FormHelperText>
            <p className="single-stat-value">{props.team.beer}</p>
          </div>
          <div className="text-right width-50">
            <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'right' }}>Score</FormHelperText>
            <p className="single-stat-value">{props.team.score}</p>

            <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'right' }}>Multiplier</FormHelperText>
            <p className="single-stat-value">{props.team.multiplier}</p>

            <FormHelperText sx={{ fontWeight: 'bold', textAlign: 'right' }}>Sodas</FormHelperText>
            <p className="single-stat-value">{props.team.soda}</p>
          </div>
        </Stack>
      </div>

      <Divider sx={{my: 2, borderColor: props.team.color}} />

      <div className="team-controls text-left">
        <h4 className="text-center mb-10">Controls</h4>

        <div className="team-control">
          <FormHelperText sx={{ fontWeight: 'bold' }}>Score (delta)</FormHelperText>
          <Stack spacing={2} direction="row">
            <input
              type="tel"
              // placeholder={props.team.score}
              value={score}
              onInput={(e) => {
                const val = e.target.value;
                if (e.target.validity.valid) {
                  setScore(e.target.value);
                } else if (val === "" || val === "-") {
                  setScore(val);
                }
              }}
              pattern="^-?[0-9]\d*\.?\d*$"
            ></input>
            <Button variant="outlined"
              onClick={() => {
                setScore("");
                props.addScore(parseInt(score), [props.team.color]);
              }}
            >
              Update
            </Button>
          </Stack>
        </div>

        <div className="team-control">
          <FormHelperText sx={{ fontWeight: 'bold' }}>Multiplier</FormHelperText>
          <Stack spacing={2} direction="row">
            <input
              type="tel"
              placeholder={props.team.multiplier}
              value={multiplier}
              onChange={(e) => {
                const val = e.target.value;
                if (e.target.validity.valid) {
                  setMultiplier(e.target.value);
                } else if (val === "" || val === "-") {
                  setMultiplier(val);
                }
              }}
              pattern="^-?[0-9]\d*\.?\d*$"
            ></input>
            <Button variant="outlined"
              onClick={() => {
                setMultiplier("");
                props.updateMultiplier(multiplier, [props.team.color]);
              }}
            >
              Update
            </Button>
          </Stack>
        </div>
      </div>
    </Box>
  );
};

export default Team;
