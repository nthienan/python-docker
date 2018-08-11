#!/usr/bin/env bash

MODE="$1"
IMAGE="$2"
VERSION="$3"
VARIANT="$4"

cd $VERSION/$VARIANT
py_ver=$(awk '/FROM python:/ {print $2}' Dockerfile | cut -d: -f2 | cut -d- -f1)
tag="$VARIANT-onbuild"

if [ "$MODE" = 'build' ]; then
    echo -e "\nBuilding $IMAGE:$py_ver-$tag..."
    docker pull $IMAGE:$py_ver-$tag || true
    docker build --pull --cache-from $IMAGE:$py_ver-$tag -t $IMAGE:$py_ver-$tag .
fi
if [ "$MODE" = "deploy" ]; then
    echo -e '\nDeploying...'
    dcd --version $py_ver --version-semver --tag $tag --verbose $IMAGE:$py_ver-$tag
fi
