#!/bin/bash
#
# Run Command Entrypoint for Docker Container of ctodd-python-flask-api-template
#
# Example: ./run-command.sh
#

python3.6 -m flask run --host=0.0.0.0 --port=5000
