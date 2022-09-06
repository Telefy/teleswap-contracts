const amountIn = 100000000;
const reserveOut = 100000000000000000000000;
const reserveIn = 100000000000;
const amountInWithFee = (amountIn * 9973) / 10;
const numerator = amountInWithFee * reserveOut;
const denominator = reserveIn * 1000 + amountInWithFee;
const amountOut = numerator / denominator;

console.log(amountOut / 10 ** 18);
console.log(amountOut.toLocaleString().replace(/,/g, ""));

console.log((0.099999999999999 / 100) * 0.045);
