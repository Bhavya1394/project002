#!/bin/bash
#There are two fundamental loop commands
#1.while
#2.for

#loops are used to iterate the commands again and again based on some logic

##while loop
#while [ expression ]; do
#commands
#done

## Ex: Run a loop for 10 times
i=10
j=1
while [ $i -gt 0 ]; do
  echo Iteration = $j
  j=$(($j+1))
  i=$(($i-1))
done

#For loop
# for var in value1 value2 ... valuen; do
#commands
#done

##Print multiple fruit names

for fruit in mango banana orange papaya watermelon guava cherries strawberry pineapple custardapple ; do
  echo $fruit
done

#above loop will iterate for 10 times as there are 10 fruits names (values)
