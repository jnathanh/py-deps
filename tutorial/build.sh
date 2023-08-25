#!/usr/bin/env bash
set -e
source venv/bin/activate

# make sure to have a valid pyproject.toml
if [ ! -f pyproject.toml ]; then
    >&2 echo "No pyproject.toml found"

    # add template pyproject.toml
    cat > pyproject.toml << EOF
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
version = "2023.0.0"
name = "hello-world-nathan-hanna"
EOF

    >&2 echo "Created pyproject.toml"
fi

# make sure build outputs are ignored by git
if [ ! -f .gitignore ] || ! grep -q "dist" .gitignore; then
    >&2 echo "Adding dist to .gitignore"

    echo "dist" >> .gitignore
fi

# build the package
python -m build

# note that the main.py which his the root of the folder is included in the distribution package
# such that it will be installed in the root of the virtual environment (i.e. not in an import package)
# so you would import it as `import main`