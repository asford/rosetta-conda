#!/bin/bash

set -x
set -e

unset MACOSX_DEPLOYMENT_TARGET

# Reset conda-forge ccache configuration
# ROOT=`pwd`
# export CCACHE_BASEDIR=`realpath "/.."`
# ccache -M 5G

TARGET_APPS="rosetta_scripts score relax AbinitioRelax"

cat source/.version.json

pushd source/cmake
echo "--- Build"
./make_project.py all

pushd build_release
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=${PREFIX}

ninja ${TARGET_APPS}

echo "--- Install"
ninja install | grep -v Installing: | grep -v Up-to-date:
popd
popd
