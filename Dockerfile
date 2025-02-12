# Stage 1
# Using PEGA shipped Search and Reporting Service(SRS) docker image as base image.
ARG SRS_IMAGE_VERSION=latest
FROM docker-release.bin.pega.io/platform-services/search-n-reporting-service:$SRS_IMAGE_VERSION as srsJarSource

# Stage 2
# Customization can be done in bellow stage
# PLEASE MAKE SURE THIS IS ALIGNED WITH THE BASE IMAGE IN distribution/escrow/build.gradle.kts
FROM docker-release.bin.pega.io/pega-jdk-17:latest
COPY */search-n-reporting-service.jar /tmp/search-n-reporting-service.jar
WORKDIR /tmp
EXPOSE 8080
CMD java -Xlog:gc*,gc+heap=debug,gc+humongous=debug:file=/tmp/srs_gc.log:time,uptime,pid,level,tags:filecount=5,filesize=10M -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/oom_heap_dump.hprof -XX:+ExitOnOutOfMemoryError -XX:MaxRAMPercentage=75 ${JAVA_OPTS} -jar search-n-reporting-service.jar
