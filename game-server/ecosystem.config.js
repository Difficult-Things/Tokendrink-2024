const path = require('path');

const npmPath = process.platform === 'win32'
    ? "C:\\Program Files\\nodejs\\node_modules\\npm\\bin\\npm-cli.js"
    : 'npm';

const defaultEnv = {
    env: {
        TIMELINE_START: 'now',
        TIMELINE_MODE: 'fast',
    },
    env_production: {
        TIMELINE_START: 'default',
        TIMELINE_MODE: 'default',
    },
}

module.exports = {
    apps: [
        {
            name: 'lassie-bridge',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:lassie-bridge',
            time: true,
            error_file : "./logs/lassie-bridge-err.log",
            out_file : "./logs/lassie-bridge-out.log",
        },
        {
            name: 'mqtt',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:mqtt',
            time: true,
            error_file : "./logs/mqtt-err.log",
            out_file : "./logs/mqtt-out.log",
        },
        {
            name: 'state-server',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:state-server',
            time: true,
            error_file : "./logs/state-server-err.log",
            out_file : "./logs/state-server-out.log",
            ...defaultEnv,
        },
        {
            name: 'scheduler',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:scheduler',
            time: true,
            error_file : "./logs/scheduler-err.log",
            out_file : "./logs/scheduler-out.log",
            ...defaultEnv,
        },
    ]
}
