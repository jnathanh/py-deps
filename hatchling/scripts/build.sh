#!/usr/bin/env bash
set -e

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

source venv/bin/activate

# make sure to have a valid pyproject.toml
if [ ! -f pyproject.toml ]; then
    >&2 echo "No pyproject.toml found"
    exit 1
fi

# make sure build outputs are ignored by git
if [ ! -f .gitignore ] || ! grep -q "dist" .gitignore; then
    >&2 echo "Adding dist to .gitignore"

    echo "dist" >> .gitignore
fi

# build the package
rm -rf dist # remove old build if it exists
python -m build
