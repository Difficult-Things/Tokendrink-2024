"use client";
import React, { useEffect } from "react";
import mqtt from "mqtt"; // import namespace "mqtt"
import { Control } from "@/components/control";
import { Footer } from "@/components/footer";
import { Header } from "@/components/header";
import { Stats } from "@/components/stats";

export default function Home() {
  const [client, setClient] = React.useState<any>(null);
  const [pullenwandConnected, setPullenwandConnected] = React.useState("OFFLINE");
  const [maingameConnected, setMaingameConnected] = React.useState("OFFLINE");
  const [dataWatcherConnected, setDataWatcherConnected] = React.useState("OFFLINE");

  const [data, setData] = React.useState<any>(null);
 
  useEffect(() => {
    if (client) {
      console.log(client);
      client.on("connect", () => {
        console.log("Connected");
        client.subscribe("gamevisuals/status");
        client.subscribe("pullenwand/status");
        client.subscribe("data-watcher/#");
      });
      client.on("error", (err: any) => {
        console.error("Connection error: ", err);
        client.end();
      });
      client.on("reconnect", () => {});
      client.on("message", (topic: string, message: any) => {
        if (topic === "gamevisuals/status") {
          setMaingameConnected(message.toString());
        }
        if (topic === "pullenwand/status") {
          setPullenwandConnected(message.toString());
        }
        if (topic === "data-watcher/status") {
          setDataWatcherConnected(message.toString());
        }
        if (topic === "data-watcher/data") {
          const json = JSON.parse(message.toString());
          setData(json);
        }
      });
    }
  }, [client]);

  useEffect(() => {
    setClient(mqtt.connect("mqtt://127.0.0.1:8888"));
  }, []);

  return (
    <main className="min-h-screen flex flex-col">
      <div className="flex-grow-0 flex-shrink basis-auto">
        <Header />
      </div>

      <div className="flex-grow flex-shrink basis-auto">
        <div className="flex flex-row">
          <div className="flex-grow flex-shrink basis-0 mx-4 rounded-lg border">
            <Control client={client} />
          </div>
          <div className="flex-grow flex-shrink basis-0 mx-4 rounded-lg border">
            <Stats data={data} />
          </div>
        </div>
      </div>

      <div className="flex-grow-0 flex-shrink basis-[40px] text-center">
        <p>Maingame is {maingameConnected}</p>
        <p>Pullenwand is {pullenwandConnected}</p>
        <p>DataWatcher is {dataWatcherConnected}</p>

        <Footer />
      </div>
    </main>
  );
}
