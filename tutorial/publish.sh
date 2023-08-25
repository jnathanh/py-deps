#!/usr/bin/env bash

set -e

source venv/bin/activate

twine upload --repository testpypi -u __token__ -p "$PYPI_TEST_API_TOKEN" dist/*