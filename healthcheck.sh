#!/bin/bash
#
# Healthcheck for the Flask App
#

declare -a processes=(
    "python3.6 -m flask run --host=0.0.0.0 --port=5000"
)

for i in "${processes[@]}"
do
    if ! pgrep -f "^${i}" > /dev/null; then
        echo "Healthcheck Failed: No process found for ${i}"
        exit 1
    fi
done

echo "Healthcheck Passed"
