#!/bin/bash
rm -f new1
sed 's/ \"wikilink\"//g' < $1 > new1
mv new1 $1
