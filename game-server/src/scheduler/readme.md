
# defaults (identical) -- runs full timeline in 2.5hrs
npm run start:scheduler
TIMELINE_START=default TIMELINE_MODE=default npm run start:scheduler

# fast mode, start now (start, build, debrief accelerated) -- runs full timeline in 26mins
TIMELINE_START=now TIMELINE_MODE=fast npm run start:scheduler

# linear mode, start now (all phases 5s) -- runs full timeline in 4min10s
TIMELINE_START=now TIMELINE_MODE=linear npm run start:scheduler

# linear mode, start now, custom duration (all phases 2s) -- runs full timeline in 1min40s
TIMELINE_START=now TIMELINE_MODE=linear TIMELINE_PHASE_DURATION=2 npm run start:scheduler

