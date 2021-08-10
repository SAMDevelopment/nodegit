#!/usr/bin/env bash

# -e            Exit immediately after command fails
# -E            ERR trap still works with -e
# -u            Unset variables cause immediate exit
# -o pipefail   Exit code of rightmost non 0 exit is used
set -Eeuo pipefail

#
# Variables
#
rootDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
imageName="nodegit"

#
# Commands
#
if [[ $# -gt 0 ]]; then
  if [[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Helper script to tag and push images."
    echo
    echo "Usage:"
    echo "  ./u.sh <COMMAND>"
    echo "  ./u.sh help|--help|-h"
    echo
    echo "Commands:"
    echo "  build NODE_VERSION GIT_VERSION      Build and tag the image"
    echo
    exit 0

  elif [[ "$1" == "build" ]]; then
    shift 1
    nodeVersion="${1}"
    gitVersion="${2}"
    DOCKER_BUILDKIT=1 docker build -t "samdevelopment/nodegit:node${nodeVersion}_git${gitVersion}" .

  else
    echo "Unknown command: ${1}"
    exit 1
  fi
else
  ${rootDir}/s.sh help
fi
