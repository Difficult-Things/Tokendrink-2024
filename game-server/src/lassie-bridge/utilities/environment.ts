import dotenvParseVariables from 'dotenv-parse-variables';

const parseEnv = (envUnparsed: any) => {
  return dotenvParseVariables(envUnparsed, {
    assignToProcessEnv: false,
    overrideProcessEnv: false,
  });
};

const environment = {
  // eslint-disable-next-line @typescript-eslint/explicit-function-return-type
  get env() {
    const parsedProcessEnv = parseEnv(process.env);

    return {
      DEBUG_NAMESPACE: 'lassie-bridge',
      DEBUG: 'lassie-bridge:*',
      MQTT_HOST_NAME: 'mqtt://localhost:1883',

      // override in pm2 ecosystem file?
      LASSIE_START_BAR_TRANSACTION_ID: 100,
      LASSIE_CHECKIN_EVENT_ID: 94,
      LASSIE_API_HOST_NAME: 'https://demo.lassie.cloud/api/v2',
      LASSIE_API_KEY: '70d0eb1f76e899e5f17d870f8387525f',
      LASSIE_API_SECRET: 'ffaf36d6e04ee9ec4e4fa67dfa83662e',
      LASSIE_API_LOGGING: false,
      ...parsedProcessEnv,
    };
  },
};

export default environment;
