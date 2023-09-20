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

outputDir="dist"

# make sure build outputs are ignored by git
if [ ! -f .gitignore ] || ! grep -q "$outputDir" .gitignore; then
    >&2 echo "Adding $outputDir to .gitignore"

    echo "$outputDir" >> .gitignore
fi

# build the package
rm -rf "$outputDir" # remove old build if it exists
# pip wheel --no-deps .
python -m build