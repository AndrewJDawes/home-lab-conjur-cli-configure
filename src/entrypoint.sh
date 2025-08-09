#!/usr/bin/env sh

set -x
set -e

# execute the /entrypoint.sh script
# this script is provided by the base image

/home-lab-conjur-cli/src/entrypoint.sh

conjur policy replace -b root -f ./policies/root/policy.yml
conjur policy replace -b conjur -f ./policies/root/conjur/policy.yml
conjur policy replace -b ci -f ./policies/root/ci/policy.yml
conjur policy replace -b ci/jenkins -f ./policies/root/ci/jenkins/policy.yml
conjur policy replace -b conjur/authn-jwt -f ./policies/root/conjur/authn-jwt/policy.yml
conjur policy replace -b conjur/authn-jwt/jenkins -f ./policies/root/conjur/authn-jwt/jenkins/policy.yml
conjur policy replace -b codekaizen -f ./policies/root/codekaizen/policy.yml
conjur policy replace -b codekaizen/website -f ./policies/root/codekaizen/website/policy.yml
conjur policy replace -b codekaizen/wp-plugin-registry -f ./policies/root/codekaizen/wp-plugin-registry/policy.yml
conjur policy replace -b umerx -f ./policies/root/umerx/policy.yml
conjur policy replace -b umerx/npm -f ./policies/root/umerx/npm/policy.yml
conjur policy replace -b umerx/ghcr -f ./policies/root/umerx/ghcr/policy.yml
conjur policy replace -b andrewjdawes -f ./policies/root/andrewjdawes/policy.yml
conjur policy replace -b andrewjdawes/woo-ai-demo -f ./policies/root/andrewjdawes/woo-ai-demo/policy.yml
conjur policy replace -b andrewjdawes/packagist -f ./policies/root/andrewjdawes/packagist/policy.yml

# The jwt's token-app-property (in this case, "aud") value will be appended to the identity-path value to form the "!host" that Conjur will authenticate the JWT token against.
# So for example, if the jwt token has an "aud" value of "cyberark-conjur", the identity-path value is "ci/jenkins", then the Conjur host that the JWT token will be authenticated against is "ci/jenkins/cyberark-conjur".

# conjur variable set -i conjur/authn-jwt/jenkins/token-app-property -v sub
conjur variable set -i conjur/authn-jwt/jenkins/token-app-property -v aud
# conjur variable set -i conjur/authn-jwt/jenkins/identity-path -v 'myspace/jwt-apps'
conjur variable set -i conjur/authn-jwt/jenkins/identity-path -v 'ci/jenkins'

conjur variable set -i conjur/authn-jwt/jenkins/issuer -v "$CONJUR_AUTHN_JWT_JENKINS_ISSUER"
conjur variable set -i conjur/authn-jwt/jenkins/jwks-uri -v "$CONJUR_AUTHN_JWT_JENKINS_JWKS_URI"
conjur variable set -i conjur/authn-jwt/jenkins/audience -v "$CONJUR_AUTHN_JWT_JENKINS_AUDIENCE"

exec "$@"
