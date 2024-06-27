#/bin/bash
for file in *.html; do
    sed -i '/polyfill.io\/v3/d' $file
done
