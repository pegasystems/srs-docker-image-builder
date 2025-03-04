# Stage 1
# Using PEGA shipped Search and Reporting Service(SRS) docker image as base image.
ARG SRS_IMAGE_VERSION=latest
FROM pega-docker.downloads.pega.com/platform-services/search-n-reporting-service:$SRS_IMAGE_VERSION as srsJarSource

# Stage 2
# Customization can be done in bellow stage
FROM alpine@sha256:483f502c0e6aff6d80a807f25d3f88afa40439c29fdd2d21a0912e0f42db842a
RUN apk update && apk upgrade expat --no-cache
RUN apk add openjdk17
COPY --from=srsJarSource */search-n-reporting-service.jar search-n-reporting-service.jar
EXPOSE 8080
CMD java -XX:+ExitOnOutOfMemoryError -XX:MaxRAMPercentage=50 ${JAVA_OPTS} -jar search-n-reporting-service.jar
