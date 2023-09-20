#!/usr/bin/env bash

# show executed commands
# set -x

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

env_dir="venv"

# create a virtual environment for this project if it doesn't exist
if [ ! -d "venv" ]; then
    >&2 echo "No virtual environment found. Creating virtual environment for this project in $env_dir"

    python3 -m venv "$env_dir"
fi

# virtual environments are not portable, so make sure it is not checked into git
if [ ! -f .gitignore ] || ! grep -q "$env_dir" .gitignore; then
    >&2 echo "Adding $env_dir to .gitignore"

    echo "$env_dir" >> .gitignore
fi

# activate the virtual environment
source "$env_dir/bin/activate"

# upgrade pip
pip install --upgrade pip

# install development dependencies
pip install -r dev-requirements.txt
