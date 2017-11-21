#!/bin/bash -f
#pandoc -f mediawiki -t gfm -o ZMATRIX----Z-matrix-input.md -s Z.mediawiki
pandoc -f mediawiki -t gfm -o $1.md -s $1.mediawiki
