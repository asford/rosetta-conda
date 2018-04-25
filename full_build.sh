#!/bin/sh

set -e
set -x

pushd ../main
source/version.py
popd

./build pyrosetta-binder --skip-existing
./build pyrosetta --python 3.6 --skip-existing
