#!/usr/bin/env bash
set -e

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

# copy the source directory to the project folder
1>&2 echo "Copying source files to $(pwd)/src"
cp -r ../src_hello ./src
