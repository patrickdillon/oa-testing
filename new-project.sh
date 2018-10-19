#!/bin/bash

name=$1
branch=$2
commitish=$3

if [ -z $name ]; then
    echo "Provide a name for the dir & git branch."
    exit 2
fi

mkdir $name
cd openshift-ansible
git worktree prune

if [ -z $commitish ] && [ -z $branch ]; then
    
    git pull upstream master
    git worktree add -b $name ../$name/openshift-ansible
    
elif [ -z $commitish ]; then
    echo "Fetch."
    git fetch upstream $branch
    echo "Add worktree."
    git worktree add -B $name ../$name/openshift-ansible upstream/$branch 

	 
else
    
    git checkout $branch
    git pull upstream $commitish:$name
    git worktree add -B $name ../$name/openshift-ansible
    
fi

cd ..
(cp -r aws-template/* $name)
