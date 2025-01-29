FROM ghcr.io/andrewjdawes/home-lab-conjur-cli:v1 AS base

ENV CONJUR_SERVER_APPLIANCE_URL=""
ENV CONJUR_ORG_ACCOUNT=""
ENV CONJUR_USERNAME=""
ENV CONJUR_PASSWORD=""
ENV CONJUR_CLI_INSECURE=false

COPY src /home-lab-conjur-cli-configure/src

WORKDIR /home-lab-conjur-cli-configure/src

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["conjur", "help"]

FROM base AS dev

RUN apk add --no-cache bash git

WORKDIR /home-lab-conjur-cli-configure
