FROM ghcr.io/andrewjdawes/home-lab-conjur-cli:v2 AS base

ENV CONJUR_SERVER_APPLIANCE_URL=""
ENV CONJUR_ORG_ACCOUNT=""
ENV CONJUR_USERNAME=""
ENV CONJUR_PASSWORD=""
ENV CONJUR_CLI_INSECURE=false
ENV CONJUR_AUTHN_JWT_JENKINS_ISSUER=""
ENV CONJUR_AUTHN_JWT_JENKINS_AUDIENCE=""
ENV CONJUR_AUTHN_JWT_JENKINS_JWKS_URI=""

WORKDIR /home-lab-conjur-cli-configure

COPY ./src /home-lab-conjur-cli-configure/src

RUN chmod +x /home-lab-conjur-cli-configure/src/entrypoint.sh

ENTRYPOINT ["/home-lab-conjur-cli-configure/src/entrypoint.sh"]

FROM base AS dev

RUN apk add --no-cache bash git

