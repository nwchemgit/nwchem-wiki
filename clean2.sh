#!/bin/bash
rm -f newa 
sed  \
 -s 's/172.26.64.155//g'  \
  $1 > newa
mv newa $1
rm -f newa 
