#!/usr/bin/env bash
set -e

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

# create test virtual environment
env_dir="venv_test"

# create a virtual environment for this project if it doesn't exist
if [ ! -d "$env_dir" ]; then
    python3 -m venv "$env_dir"
fi

# activate the virtual environment
source "$env_dir/bin/activate"

# upgrade pip
pip install --upgrade pip

# install the package
pkg_name=$(grep -m 1 name pyproject.toml | tr -s ' ' | tr -d '"' | tr -d "'" | cut -d' ' -f3)
pkg_ver=$(grep -m 1 version pyproject.toml | tr -s ' ' | tr -d '"' | tr -d "'" | cut -d' ' -f3)

# wait for index to be updated
for i in {1..5}; do
    if pip index versions  --index-url https://test.pypi.org/simple/ "$pkg_name" | grep "$pkg_ver"; then
        break
    fi
    1>&2 echo "Package $pkg_name@$pkg_ver not available on the index, waiting 1 second until retry"
    sleep 1
done

if pip index versions  --index-url https://test.pypi.org/simple/ "$pkg_name" | grep "$pkg_ver"; then
    break
else
    1>&2 echo "Package $pkg_name@$pkg_ver not available on the index"
    exit 1
fi

pip install --index-url https://test.pypi.org/simple/ --no-deps "$pkg_name"=="$pkg_ver"

# verify that the package is usable
python -c'import hellonh.main; hellonh.main.hello_world()'

# cleanup
deactivate
rm -rf "$env_dir"