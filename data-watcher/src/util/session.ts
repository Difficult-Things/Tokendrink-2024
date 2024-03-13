import { GenerationType, ProductType, allGenerations } from "../types/types";
import { Generation } from "./generation";

export class Session {
  private generations: { [generation: string]: Generation } = {};

  processPDF(text: string): void {
    const lines = text.split("\n");
    const tableStartIndex = lines.findIndex((line) =>
      line.includes("Sales product name")
    );

    if (tableStartIndex === -1) {
      console.error("No sales product name found");
      return;
    }

    const tableEndIndex = lines.findIndex(
      (line, i) => i > tableStartIndex && line.charAt(0) === "€"
    );

    const table = lines.slice(tableStartIndex + 1, tableEndIndex);
    table.forEach((line) => {
      const [product, amount] = line.split(" ");

      // Check if product is one of the known products
      if (!product.includes("Beer") && !product.includes("Soda")) return;

      const type = product.includes("Beer") ? "beer" : "soda" as ProductType;
      
      let gen = undefined as GenerationType;
      if (type === "beer") {
        gen = product.split("_")[0].toLowerCase() as GenerationType;
      } else if (type === "soda") {
        gen = product.split("_")[1].toLowerCase() as GenerationType;
      } 

      if (!gen) return;

      console.log(gen, type, amount);

      this.generations[gen].addProduct(type, parseInt(amount));

    });
  }

  showData(): void {
    for (const gen of allGenerations) {
      console.log(gen, this.generations[gen], this.generations[gen].getScore());
    }
  }

  constructor() {
    for (const gen of allGenerations) {
      this.generations[gen] = new Generation();
    }
  }

}
