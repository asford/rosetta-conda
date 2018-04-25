#!/bin/bash

set -x
set -e

ROOT=`pwd`

# Reset conda-forge ccache configuration
# export CCACHE_BASEDIR=`realpath "$ROOT/.."`
# ccache -M 5G

cat source/.version.json

pushd source/src/python/PyRosetta

BUILD_ARGS="
--version $ROOT/source/.version.json
--binder-config rosetta.config
--binder-config rosetta.distributed.config
--serialization
--multi_threaded
--no-strip-module
--create-package $ROOT/pyrosetta
--binder `which pyrosetta-binder`
"

python build.py $BUILD_ARGS -j

popd

pushd $ROOT/pyrosetta
# Run initial test to prebuild databases
python -c 'import pyrosetta; pyrosetta.init(); pyrosetta.get_score_function()(pyrosetta.pose_from_sequence("TEST"))'

pushd setup
pip install .
popd
