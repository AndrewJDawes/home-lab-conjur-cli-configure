#!/usr/bin/env sh

set -x
set -e

# execute the /entrypoint.sh script
# this script is provided by the base image

/entrypoint.sh

conjur policy replace -b root -f ./policies/root/policy.yml
conjur policy replace -b conjur -f ./policies/root/conjur/policy.yml
conjur policy replace -b ci -f ./policies/root/ci/policy.yml
conjur policy replace -b ci/jenkins -f ./policies/root/ci/jenkins/policy.yml
conjur policy replace -b conjur/authn-jwt -f ./policies/root/conjur/authn-jwt/policy.yml
conjur policy replace -b conjur/authn-jwt/jenkins -f ./policies/root/conjur/authn-jwt/jenkins/policy.yml
# conjur policy replace -b ci/jenkins/projects -f ./policies/root/ci/jenkins/projects/policy.yml

exec "$@"
