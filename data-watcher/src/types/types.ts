export const allGenerations = ["blue", "red", "green", "orange", "purple"] as const;

export const beerBlue = "Blue_Beer";
export const beerRed = "Red_Beer";
export const beerGreen = "Green_Beer";
export const beerOrange = "Orange_Beer";
export const beerPurple = "Purple_Beer";

export const sodaBlue = "Soda_Blue";
export const sodaRed = "Soda_Red";
export const sodaGreen = "Soda_Green";
export const sodaOrange = "Soda_Orange";
export const sodaPurple = "Soda_Purple";

export type ProductType = "beer" | "soda";
export type GenerationType = "blue" | "red" | "green" | "orange" | "purple" | undefined;