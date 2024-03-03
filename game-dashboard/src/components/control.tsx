import * as React from "react";
import { Button } from "./ui/button";
import { Tabs, TabsList } from "./ui/tabs";
import { TabsTrigger } from "@radix-ui/react-tabs";

export function Control() {
  return (
    <div className="flex flex-col m-4 gap-4">
      <h2 className="text-lg font-bold">CONTROLS</h2>

      <div className="flex flex-col items-center">
        <Tabs defaultValue="1">
          <TabsList>
            <TabsTrigger value="1">1</TabsTrigger>
            <TabsTrigger value="2">2</TabsTrigger>
            <TabsTrigger value="3">3</TabsTrigger>
            <TabsTrigger value="4">4</TabsTrigger>
            <TabsTrigger value="5">5</TabsTrigger>
          </TabsList>
        </Tabs>
        <Button variant={"destructive"} className="w-32">
          Launch 🚀
        </Button>
      </div>
    </div>
  );
}
