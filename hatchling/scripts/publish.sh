#!/usr/bin/env bash

set -e

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

source venv/bin/activate

twine upload --repository testpypi -u __token__ -p "$PYPI_TEST_API_TOKEN" dist/*