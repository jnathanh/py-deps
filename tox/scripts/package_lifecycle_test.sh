#!/usr/bin/env bash
set -e

# Function to handle error
handle_error() {
    local retval=$?
    local line=${last_lineno:-$1}
    echo -e "\n\e[31mFailed at $line: $BASH_COMMAND"
    echo "Trace: " 
    for i in $(seq 1 $((${#FUNCNAME[@]} - 2))); do
        local func="${FUNCNAME[$i]}"
        [ x$func = x ] && func=MAIN
        local line="${BASH_LINENO[$((i - 1))]}"
        local src="${BASH_SOURCE[$((i - 1))]}"
        echo -e "\t$func() in $src:$line"
    done
    echo -e "\e[0m"
}

# Trap ERR and DEBUG signals to print error messages and stack trace
trap 'last_lineno=$LINENO' DEBUG
trap 'handle_error $LINENO' ERR

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