import { TeamColors } from '../../../specifications/Common';
import { GlobalLassieEvent, LassieState } from '../../../specifications/LassieOutput';

export type MqttMessageCallback<T> = (topic: string, message: T) => void;

export type LassiePollerId = 'transactions' | 'checkinTotals' | 'checkinPersons';
export type LassiePollerTimeouts = Record<LassiePollerId, NodeJS.Timeout | undefined>;

export interface LassieGenerationTransactionsData {
  [key: string]: LassieGenerationTransaction;
}
export interface LassieGenerationTransaction {
  id: string,
  active: string,
  type_id: string,
  source_id: string,
  source_type_id: string,
  target_id: string,
  target_type_id: string,
  person_id: string,
  product_id: string,
  product_table_name: string,
  quantity: string,
  unit_id: string,
  unit_amount: string,
  delta_balance: string,
  costcenter_number: string,
  product_info: string,
  account_info: string,
  user_id: string,
  request_id: string,
  parent_id: string,
  extra_info: string,
  in_waiting_list: string,
  create_timestamp: string,
  update_timestamp: string,
  unique_id: string,
  __module_name: string,
  request_id_arr: [string],
  __origin_table_name: string,
  __origin_record_id: string,
  __quantity: string,
  __source_id: string,
  __product_id: string,
  has_refund_request: number,
  generation_id: string | number,
};

export interface LassieCheckinsPersonsData {
  [key: string]: LassieCheckinPerson;
}
export interface LassieCheckinPerson {
  id: string;
  active: string;
  event_id: string;
  person_id: string;
  create_timestamp: string;
  update_timestamp: string;
  unique_id: string;
  full_name: string;
  persons_view_id: string;
  persons_view_id_arr: string[];
  __origin_table_name: string;
  __origin_record_id: string;
}

export interface LassieCheckinsTotalsData {
  [key: string]: number;
}

export type GenerationTeamLookup = Record<number, TeamColors>;

export interface ExtendedLassieState extends LassieState {
  singleDrinkOrders: Required<GlobalLassieEvent['singleDrinkOrders']>;
}
