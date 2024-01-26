import { isString } from 'lodash';
import { TeamColors } from '../../../../specifications/Common';
import { GenerationTeamLookup } from '../types';

/**
 * Time constants
 */
export const ONE_SECOND = 1000;
export const LASSIE_TRANSACTION_POLLING_INTERVAL = ONE_SECOND * 10;
export const LASSIE_CHECKIN_TOTALS_POLLING_INTERVAL = ONE_SECOND * 20;
export const LASSIE_CHECKIN_PERSONS_POLLING_INTERVAL = ONE_SECOND * 20;

/**
 * MQTT constants
 */
export const INPUT_TOPIC = '/lassie/input';
export const OUTPUT_TOPIC = '/lassie/output';
export const TEST_TOPIC = '/lassie/test';

/**
 * Beer identifiers
 */
export const BEER_IDENTIFIERS = [
  152,
];
export const BEER_NAME_IDENTIIERS = [
  'pilsener',
  'hertog',
  'jan',
  'beer',
  'bier',
];

/**
 * Team mappings
 */
// TODO: add more generations
export const generationTeamLookup: GenerationTeamLookup = {
  2000: 'purple',
  2001: 'blue',
  2002: 'red',
  2003: 'orange',
  2004: 'green',

  2005: 'purple',
  2006: 'blue',
  2007: 'red',
  2008: 'orange',
  2009: 'green',

  2010: 'purple',
  2011: 'blue',
  2012: 'red',
  2013: 'orange',
  2014: 'green',

  2015: 'purple',
  2016: 'blue',
  2017: 'red',
  2018: 'orange',
  2019: 'green',

  2020: 'purple',
  2021: 'blue',
  2022: 'red',
  2023: 'orange',
  2024: 'green',
}

export function getTeamColorByGeneration(generationId: string | number): TeamColors | null {
  let formattedGenerationId = isString(generationId) ? parseInt(generationId) : generationId;

  return generationTeamLookup?.[formattedGenerationId] ?? null;
};
