#!/bin/bash -f
# requires readme2tex modified code from
# https://github.com/edoapra/readme2tex.git
#python -m readme2tex --username nwchemgit --project nwchem --wiki --output ZMATRIX----Z-matrix-input.md  ZMATRIX----Z-matrix-input_in.md
cp $1.md $1_tmp.md
sed -i 's/\\(/\$/g' $1_tmp.md
sed -i 's/\\)/\$/g' $1_tmp.md
python -m readme2tex --username nwchemgit --project nwchem --wiki --output $1.md  $1_tmp.md

