#!/usr/bin/env bash

IMAGE="$1"
BRANCH="$2"

if [ "$BRANCH" = 'master' ]; then
    docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD
fi

py_ver_dirs=$(ls -d */)
for py_ver_dir in $py_ver_dirs; do
    cd $py_ver_dir    
    variants=$(ls -d */)
    
    for variant in $variants; do
        cd $variant
        py_ver=$(awk '/FROM python:/ {print $2}' Dockerfile | cut -d: -f2 | cut -d- -f1)
        tag=$(awk '/FROM python:/ {print $2}' Dockerfile | cut -d: -f2 | cut -d- -f2)-onbuild
        
        echo -e "\nBuilding $IMAGE:$py_ver-$tag..."
        docker pull $IMAGE:$py_ver-$tag || true
        docker build --pull --cache-from $IMAGE:$py_ver-$tag -t $IMAGE:$py_ver-$tag .
        if [ "$BRANCH" = 'master' ]; then
            echo -e '\nDeploying...'
            dcd --version $py_ver --version-semver --tag $tag --verbose --dry-run $IMAGE:$py_ver-$tag
        fi
        cd ..
    done

    cd ..
done