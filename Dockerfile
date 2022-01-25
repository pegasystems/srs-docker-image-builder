# Stage 1
# Using PEGA shipped Search and Reporting Service(SRS) docker image as base image.
ARG SRS_IMAGE_VERSION=latest
FROM pega-docker.downloads.pega.com/platform-services/search-n-reporting-service:$SRS_IMAGE_VERSION as srsJarSource

# Stage 2
# Customization can be done in bellow stage
FROM adoptopenjdk/openjdk11-openj9:x86_64-alpine-jdk-11.0.13_8_openj9-0.29.0-slim
COPY --from=srsJarSource ./search-n-reporting-service.jar search-n-reporting-service.jar
EXPOSE 8080
CMD java -XX:+ExitOnOutOfMemoryError -XX:MaxRAMPercentage=50 ${JAVA_OPTS} -jar search-n-reporting-service.jar