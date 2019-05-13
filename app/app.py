#!/usr/bin/env python3.6
"""
    Purpose:
        App File and Entry Point for Flask API

    function call:
        export FLASK_APP=app.py; python3.6 -m flask run
"""

# Python Library Imports
import os
import subprocess
import sys
from flask import (
    abort,
    flash,
    Flask,
    g,
    jsonify,
    redirect,
    render_template,
    request,
    Response,
    session,
    url_for,
)
from logging_helpers import loggers

# Local Library Imports
BASE_PROJECT_PATH = f"{os.path.dirname(os.path.realpath(__file__))}/../"
sys.path.insert(0, BASE_PROJECT_PATH)
from config import config

# Load Config
CONFIGS = config.Config.get()

# Configure Logging
logging = loggers.get_stdout_logging(
    log_level=CONFIGS.LOG_LEVEL,
    log_prefix="[app.py] "
)

# Start Flask App
app = Flask(__name__)


###
# Endpoints
###

@app.route('/')
def index():
    """
    Purpose:
        Return README for project if not specific endpoint is called
    """

    content = open(f"{BASE_PROJECT_PATH}/README.md")
    return Response(content, mimetype="ext/markdown; charset=UTF-8")
