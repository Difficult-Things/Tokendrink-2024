"use client";

import { Control } from "@/components/control";
import { Footer } from "@/components/footer";
import { Header } from "@/components/header";
import { Stats } from "@/components/stats";

export default function Home() {
  return (
    <main className="min-h-screen flex flex-col">
      <div className="flex-grow-0 flex-shrink basis-auto">
        <Header />
      </div>

      <div className="flex-grow flex-shrink basis-auto">
        <div className="flex flex-row">
          <div className="flex-grow flex-shrink basis-0 mx-4 rounded-lg border">
            <Control />
          </div>
          <div className="flex-grow flex-shrink basis-0 mx-4 rounded-lg border">
            <Stats />
          </div>
        </div>
      </div>

      <div className="flex-grow-0 flex-shrink basis-[40px] text-center">
        <Footer />
      </div>
    </main>
  );
}
