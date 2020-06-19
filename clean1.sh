#!/bin/bash
rm -f newa newb
sed '/130.20./d'  $1 > newa
sed '/You\ are\ encoura/d'  newa > newb 
mv newb $1
rm -f newa
