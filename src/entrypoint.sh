#!/usr/bin/env sh

# execute the /entrypoint.sh script
# this script is provided by the base image

/entrypoint.sh

conjur policy load -b root -f ./policy/root.yml

exec "$@"
