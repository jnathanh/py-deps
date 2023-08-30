#!/usr/bin/env bash
set -e

# change context to the project root
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

# setup
./scripts/rm_src.sh
./scripts/create_src.sh
./scripts/setup.sh

# run
1>&2 printf "\nRunning as main module\n==================================================================\n\n"
./scripts/run.sh

# test
1>&2 printf "\nRunning tests\n==================================================================\n\n"
./scripts/test.sh

# build and publish
1>&2 printf "\nBuilding the package\n==================================================================\n\n"
./scripts/build.sh

1>&2 printf "\nPublishing the package\n==================================================================\n\n"
./scripts/publish.sh

# test that the package is installable
1>&2 printf "\nTesting that the package is installable\n==================================================================\n\n"
./scripts/test_install.sh

# cleanup
./scripts/rm_src.sh