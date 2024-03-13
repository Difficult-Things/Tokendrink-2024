import { ProductType } from "../types/types";


export class Generation {

    private products: { [product: string]: number } = {};

    addProduct(product: ProductType, amount: number): void {
        if (this.products[product]) {
            this.products[product] += amount;
        } else {
            this.products[product] = amount;
        }
    }

    getScore(): number {
        return Object.values(this.products).reduce((acc, cur) => acc + cur, 0);
    }

}