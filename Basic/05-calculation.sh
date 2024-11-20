#!/bin/bash

echo "Enter Num1 value"

read num1

echo "Enter Num2 value"

read num2 

sum=$((num1 + num2))
difference=$((num1 - num2))
product=$((num1 * num2))
quotient=$((num1 / num2))

echo "Sum: $sum"
echo "Difference: $difference"
echo "Product: $product"
echo "Quotient: $quotient"

