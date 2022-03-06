#!/bin/bash
sample () {
  echo hello, Iam a sample function
  echo value of a=${a}
  b=200
  echo first argument in function=$1
}

a=100
sample ABC
echo value of b=${b}
echo first argument in main program=$1