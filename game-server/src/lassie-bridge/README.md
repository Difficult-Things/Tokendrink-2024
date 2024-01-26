TODO:
- x totals per generation as aggregates for specific timestamp
- x deltas per generation as aggregates after specific timestamp
- x full transaction log
- x full check in log
- x expand lassie stats according to spec
- x fix beer classification
- x integrate dotenv file for Lassie Lucid environment and test it with example file
- x add single drink orders
- x add oldest member support
- caching on file system

Make sure to setup before tokendrink:
- Set to lucid.lassie.cloud credentials in .env file
- Make sure API has permissions on the following methods (in api rights admin panel):
  - GET_CHECKINS_BY_EVENT_ID
  - GET_GENERATION_CHECKINS_BY_EVENT_ID
  - GET_NEW_GENERATION_TRANSACTIONS
- Set to latest bar transaction that you want to have included
- Make sure the rate limit is high enough in Lucid Lassie
