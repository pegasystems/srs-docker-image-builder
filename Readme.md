# Building a Search and Reporting Service(SRS) docker image

To build your own SRS Docker image, you must have `docker cli` installed on your local system before you begin this procedure.

## SRS Image customization

If you do not want to use the Pega-provided Docker image,you can use the bellow process to create your preferred SRS docker image. When making customizations for your environment, check the [Pega Platform Support Guide Resources](https://community.pega.com/knowledgebase/articles/pega-platform-support-guide-resources) to verify that those changes are supported by your Pega Platform version. If you choose to build your own image, Pega will continue to offer support for Pega Platform, but problems that arise from your custom image are not the responsibility of Pegasystems.

This section describes how you can use a [multi-stage docker builds](https://docs.docker.com/develop/develop-images/multistage-build/) for building a custom SRS docker image with [Dockerfile](Dockerfile).

For clients who need to build their own deployment image, Pega recommends building your SRS image by updating the `Stage 2` in provided [Dockerfile](Dockerfile).

Follow the below steps to create a SRS Docker image that you can use to install or upgrade SRS backingservice.

With access credentials to the Pega Docker image repository, you log in to docker

1. From a Linux bash shell, ensure you are logged in to your DockerHub account:

   `$ docker login -u <username> -p <username-password>`

For details about logging into Docker from a secure password file using the `--password-stdin` option, see <https://docs.docker.com/engine/reference/commandline/login/>.

2. Customize the provided [Dockerfile](Dockerfile) as per your environment.

3. Run `$ docker build --build-arg SRS_IMAGE_VERSION=<SRS_IMAGE_VERSION> -t platform-services/search-n-reporting-service:<SRS_IMAGE_VERSION> .` command at root path of srs-docker-image-builder i.e, `path-to-project/srs-docker-image-builder/`

`SRS_IMAGE_VERSION` is the version that is having PEGA shipped SRS docker image version.By default, the value is `latest`

4. Run `$ docker images` to find the generated SRS docker image.

Note: Make sure to use the **same value** for **<SRS_IMAGE_VERSION>** parameter throughout the process.

## Tag SRS Image and push to docker private repository

1. Tag the local version of your new image,search-n-reporting-service, with your private Docker repository
   
   `$ docker tag platform-services/search-n-reporting-service:<SRS_IMAGE_VERSION> <your-docker-private-repository>/search-n-reporting-service:<SRS_IMAGE_VERSION>`
2. From a Linux bash shell, use the Docker command to push the new image to
   your private registry:

   `$ docker push <your-docker-private-repository>/search-n-reporting-service:<SRS_IMAGE_VERSION>`
