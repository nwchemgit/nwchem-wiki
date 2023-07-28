#!/bin/bash
git config user.name "nwchemgit"
git config user.email "nwchemgit@gmail.com"
git config advice.updateSparsePath false
#git add -A
TZ='America/Los_Angeles'; export TZ
if git add .
then
    git commit -m website\ changes\ on\ `date +%a_%b_%d_%H:%M:%S_%Y`
fi
exit 0
#git diff --stat --cached origin/master

