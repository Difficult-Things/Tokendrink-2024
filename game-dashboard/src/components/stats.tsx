import * as React from "react";
import { Button } from "./ui/button";
import { Table, TableHeader } from "./ui/table";
import { ColumnDef, getCoreRowModel, useReactTable } from "@tanstack/react-table";
import { DataTable } from "./stats/data-table";

import { ArrowUpDown, MoreHorizontal } from "lucide-react";
import { columns } from "./stats/columns";

// const mockData: Generation[] = [
//   { colour: "Red", beers: 10, sodas: 5, score: 15 },
//   { colour: "Green", beers: 5, sodas: 10, score: 15 },
//   { colour: "Blue", beers: 7, sodas: 7, score: 14 },
//   { colour: "Purple", beers: 8, sodas: 6, score: 14 },
//   { colour: "Orange", beers: 6, sodas: 8, score: 14 },
// ];

export function Stats( props: any ) {

  return (
    <div className="flex flex-col m-4 gap-4">
      <h2 className="text-lg font-bold">STATISTICS</h2>

      <div className="flex flex-col items-center">

        {/* Dont render if props.data === null */
        props.data == null ? <p>Loading...</p> : <DataTable columns={columns} data={props.data} />}

      </div>
    </div>
  );
}
