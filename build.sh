rm output.js || true
rm -rf output/ || true
pulp build -O -t temp.js
uglifyjs temp.js -m -c -o output.js
rm temp.js

