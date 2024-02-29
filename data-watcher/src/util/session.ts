export class Session {
  private products: string[] = [];
  private amounts: number[] = [];
  private netCosts: number[] = [];

  private processRawText(text: string): void {
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
      const [product, amount, netCost] = line.split("\t");
      this.addProduct(product, +amount, +netCost);
    });

    console.log(this.products);
  }

  constructor(text: string) {
    this.processRawText(text);
  }

  addProduct(product: string, amount: number, netCost: number): void {
    this.products.push(product);
    this.amounts.push(amount);
    this.netCosts.push(netCost);
  }

  removeProduct(product: string, amount: number): void {
    const index = this.products.indexOf(product);
    if (index !== -1) {
      this.amounts[index] -= amount;
      if (this.amounts[index] <= 0) {
        this.products.splice(index, 1);
        this.amounts.splice(index, 1);
        this.netCosts.splice(index, 1);
      }
    }
  }

  getProducts(): string[] {
    return this.products;
  }

  getAmounts(): number[] {
    return this.amounts;
  }

  getNetCosts(): number[] {
    return this.netCosts;
  }

  getTotalAmount(): number {
    return this.amounts.reduce((acc, curr) => acc + curr, 0);
  }

  getTotalNetCost(): number {
    return this.netCosts.reduce((acc, curr) => acc + curr, 0);
  }
}
