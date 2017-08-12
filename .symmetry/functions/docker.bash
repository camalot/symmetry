#!/usr/bin/env bash

dcleanup(){
	local containers=( $(docker ps -aq 2>/dev/null) );
	docker rm "${containers[@]}" 2>/dev/null;
	local volumes=( $(docker ps --filter status=exited -q 2>/dev/null) );
	docker rm -v "${volumes[@]}" 2>/dev/null;
	local images=( $(docker images --filter dangling=true -q 2>/dev/null) );
	docker rmi "${images[@]}" 2>/dev/null;
}
