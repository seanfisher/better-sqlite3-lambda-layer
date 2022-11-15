#!/bin/bash -x

set -e

# Clears out layer staging directory
rm -rf layer && mkdir -p layer/nodejs/node_modules

# Copies package.json to build directory
rm -rf build && mkdir build && cp package.json build

# Rebuilds native node modules using lambda environment
cd build
docker run --rm -v "$PWD":/var/task public.ecr.aws/sam/build-${RUNTIME}.x npm install --only=prod
cd ..

# Copies build into layer staging directory
cp -r build/node_modules/ layer/nodejs/node_modules