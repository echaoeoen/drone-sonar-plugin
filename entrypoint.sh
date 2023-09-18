#!/bin/bash

set -euo pipefail

MY_EXECUTABLE=sonar-scanner
ARGS=()
ARGS+=("-Dsonar.host.url="${SONAR_URL:-$PLUGIN_URL})
ARGS+=("-Dsonar.login="${SONAR_TOKEN:-$PLUGIN_TOKEN})
ARGS+=("-Dsonar.projectVersion="${DRONE_BUILD_NUMBER:-"0"})
ARGS+=("-Dsonar.scm.provider="${DRONE_REPO_SCM:-"git"})
ARGS+=("-Dsonar.pullrequest.key="${DRONE_PULL_REQUEST:-"0"})
ARGS+=("-Dsonar.pullrequest.branch="${DRONE_SOURCE_BRANCH:-"master"})
ARGS+=("-Dsonar.pullrequest.base="${DRONE_TARGET_BRANCH:-"master"})

if [ "$#" -eq 0 ]; then
	set -- "$MY_EXECUTABLE" "${ARGS[@]}"
elif [ "${1:0:1}" = '-' ]; then
    set -- "$MY_EXECUTABLE" "${ARGS[@]}" "$@"
fi

export SONAR_USER_HOME=${SONAR_USER_HOME:-.sonar}
exec "$@"