import * as React from "react";
import { Button } from "./ui/button";
import { Tabs, TabsList } from "./ui/tabs";
import { TabsTrigger } from "@radix-ui/react-tabs";
import * as Select from "@radix-ui/react-select";
import * as AlertDialog from "@radix-ui/react-alert-dialog";
import "./alertStyling.css";
import Nestable from "react-nestable";
import "react-nestable/dist/styles/index.css"; //Werd aangeraden om hier te doen, idk waarom

export function Control(props: any) {
  const [round, setRound] = React.useState("1");
  const [roundState, setRoundState] = React.useState("drinking");
  const [ranking, setRanking] = React.useState([
    { id: 0, text: "Red" },
    { id: 1, text: "Green" },
    { id: 2, text: "Blue" },
    { id: 3, text: "Purple" },
    { id: 4, text: "Orange" },
  ]);

  const renderItem = ({ item }: any) => item.text;

  const doSomethingWithChange = (items: any) => {
    setRanking(items.items);
    return true;
  };

  return (
    <div className="flex flex-col m-4 gap-4">
      <h2 className="text-lg font-bold">CONTROLS</h2>

      <div className="flex flex-col items-center">
        {/* <Tabs defaultValue="1">
          <TabsList>
            <TabsTrigger value="1">1</TabsTrigger>
            <TabsTrigger value="2">2</TabsTrigger>
            <TabsTrigger value="3">3</TabsTrigger>
            <TabsTrigger value="4">4</TabsTrigger>
            <TabsTrigger value="5">5</TabsTrigger>
          </TabsList>
        </Tabs> */}
        <div className="m-5">
          <Nestable maxDepth={1} onChange={doSomethingWithChange} items={ranking} renderItem={renderItem} />
        </div>

        <div className="flex row">
          <div className="m-5">
            <Select.Root value={round} onValueChange={setRound}>
              <Select.Trigger>
                <Select.Value aria-label={round}>{round}</Select.Value>
                <Select.Icon />
              </Select.Trigger>
              <Select.Portal>
                <Select.Content position="popper" sideOffset={5} className="bg-slate-700">
                  <Select.Viewport>
                    <Select.Item value="1">
                      <Select.ItemText>Roulette</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                    <Select.Item value="2">
                      <Select.ItemText>Slots</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                    <Select.Item value="3">
                      <Select.ItemText>Plinko</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                    <Select.Item value="4">
                      <Select.ItemText>Grijper</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                    <Select.Item value="5">
                      <Select.ItemText>Paardenrace</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                  </Select.Viewport>
                </Select.Content>
              </Select.Portal>
            </Select.Root>
          </div>

          <div className="m-5">
            <Select.Root value={roundState} onValueChange={setRoundState}>
              <Select.Trigger>
                <Select.Value aria-label={roundState}>{roundState}</Select.Value>
                <Select.Icon />
              </Select.Trigger>
              <Select.Portal>
                <Select.Content position="popper" sideOffset={5} className="bg-slate-700">
                  <Select.Viewport>
                    <Select.Item value="drinking">
                      <Select.ItemText>drinking</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                    <Select.Item value="reveal">
                      <Select.ItemText>reveal</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                    <Select.Item value="play">
                      <Select.ItemText>play</Select.ItemText>
                      <Select.ItemIndicator>…</Select.ItemIndicator>
                    </Select.Item>
                  </Select.Viewport>
                </Select.Content>
              </Select.Portal>
            </Select.Root>
          </div>
        </div>

        <AlertDialog.Root>
          <AlertDialog.Trigger asChild>
            <button className="Button violet"> Launch 🚀</button>
          </AlertDialog.Trigger>
          <AlertDialog.Portal>
            <AlertDialog.Overlay className="AlertDialogOverlay" />
            <AlertDialog.Content className="AlertDialogContent">
              <AlertDialog.Title className="AlertDialogTitle">Are you absolutely sure?</AlertDialog.Title>
              <AlertDialog.Description className="AlertDialogDescription">This will update the game!!</AlertDialog.Description>
              <div style={{ display: "flex", gap: 25, justifyContent: "flex-end" }}>
                <AlertDialog.Cancel asChild>
                  <button className="Button mauve">Cancel</button>
                </AlertDialog.Cancel>
                <AlertDialog.Action asChild>
                  <button
                    className="Button red"
                    onClick={() => {
                      console.log(ranking);
                      props.client.publish(
                        "gamevisuals/gamestate",
                        JSON.stringify({
                          round: parseInt(round),
                          state: roundState,
                          ranking: {
                            red: ranking.findIndex(item => item.text === "Red") + 1,
                            green: ranking.findIndex(item => item.text === "Green") + 1,
                            orange: ranking.findIndex(item => item.text === "Orange") + 1,
                            blue: ranking.findIndex(item => item.text === "Blue") + 1,
                            purple:  ranking.findIndex(item => item.text === "Purple") + 1,
                          },
                        })
                      );
                    }}
                  >
                    Yes, update game state
                  </button>
                </AlertDialog.Action>
              </div>
            </AlertDialog.Content>
          </AlertDialog.Portal>
        </AlertDialog.Root>
      </div>
    </div>
  );
}
