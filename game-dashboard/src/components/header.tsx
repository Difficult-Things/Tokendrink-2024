import * as React from "react";
import { ModeToggle } from "./ui/modeToggle";

export function Header() {
  return (
    <header className="flex justify-between items-center p-4 mx-8">
      <h1 className="text-2xl font-bold">TOKENDRINK 2024 - Dashboard 💸</h1>
      <ModeToggle />
    </header>
  );
}
