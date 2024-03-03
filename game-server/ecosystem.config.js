const path = require('path');

const npmPath = process.platform === 'win32'
    ? "D:\\Program Files\\nodejs\\node_modules\\npm\\bin\\npm-cli.js"
    : 'npm';

    // const npmPath = "npm"

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
            name: 'mqtt',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:mqtt',
            time: true,
            error_file : "./logs/mqtt-err.log",
            out_file : "./logs/mqtt-out.log",
        },
        {
            name: 'dataWatcher',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:dataWatcher',
            time: true,
            error_file : "./logs/dataWatcer-err.log",
            out_file : "./logs/dataWatcher-out.log",
        },
        {
            name: 'dashboard',
            script: npmPath,
            cwd: __dirname,
            args: 'run start:dashboard',
            time: true,
            error_file : "./logs/dashboard-err.log",
            out_file : "./logs/dashoard-out.log",
        },


    ]
}
