ARG BUILD_FROM=ghcr.io/hassio-addons/base:latest
FROM $BUILD_FROM

# Install dependencies
RUN apk add --no-cache curl iputils mosquitto-clients jq

# Copy addon files
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
