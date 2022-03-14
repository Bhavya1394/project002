#!/bin/bash
#There are two fundamental loop commands
#1.while
#2.for

#loops are used to iterate the commands again and again based on some logic

##while loop
#while [ expression ] ; do
#commands
#done

## Ex: Run a loop for 10 times
i=10
while [ $i -gt 0 ]; do
  echo Iteration = $i
  i=$(($i-1))
done