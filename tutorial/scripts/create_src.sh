#!/usr/bin/env bash
set -e

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

# copy the source directory to the project folder
1>&2 echo "Copying source files to $(pwd)/src"
cp -r ../src_hello ./src

# make sure the source files are ignored by git (because they are copied from outside the project)
if [ ! -f .gitignore ] || ! grep -q "src" .gitignore; then
    >&2 echo "Adding src to .gitignore"

    echo "src" >> .gitignore
fi
