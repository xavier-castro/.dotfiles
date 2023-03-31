#!/usr/bin/env bash

function run_gpc {
	echo "Running gpc..."
	git add . && git commit -a
}

run_gpc
