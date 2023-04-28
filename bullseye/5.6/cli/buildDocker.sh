#!/usr/bin/env bash

# set -xe
echo -e "buildDocker.sh\r";

export $(egrep -v '^#' .env | xargs)

# Proxy settings
PROXY_SETTINGS=""
# if [ "${http_proxy}" != "" ]; then
#   PROXY_SETTINGS="$PROXY_SETTINGS --build-arg http_proxy=${http_proxy}"
# fi

# if [ "${https_proxy}" != "" ]; then
#   PROXY_SETTINGS="$PROXY_SETTINGS --build-arg https_proxy=${https_proxy}"
# fi

# if [ "${ftp_proxy}" != "" ]; then
#   PROXY_SETTINGS="$PROXY_SETTINGS --build-arg ftp_proxy=${ftp_proxy}"
# fi

# if [ "${no_proxy}" != "" ]; then
#   PROXY_SETTINGS="$PROXY_SETTINGS --build-arg no_proxy=${no_proxy}"
# fi

# if [ "$PROXY_SETTINGS" != "" ]; then
#   echo "Proxy settings were found and will be used during the build."
# fi

DOCKER_NAME="rodrixcornell"
DOCKER_NAME="rodrigocabral78"

IMAGE_NAME=${DOCKER_NAME}"/php:$(echo $php_version | cut -c1-3)"

IMAGE_BUILD="--build-arg php_version=${php_version} --build-arg variant=${variant} --build-arg codename=${codename} --build-arg release=${release} --build-arg distribution=${distribution} --build-arg oracle_latest=${oracle_latest}"

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
# docker build ${IMAGE_BUILD} ${PROXY_SETTINGS} \
# --tag ${IMAGE_NAME}-${variant}-${codename} \
# --tag ${IMAGE_NAME}-${variant} \
# --tag ${IMAGE_NAME}-${codename} \
# --tag ${IMAGE_NAME} \
# --tag ${DOCKER_NAME}/php:${variant}-${codename} \
# --tag ${DOCKER_NAME}/php:${variant} \
# --tag ${DOCKER_NAME}/php:${codename} \
# --tag ${DOCKER_NAME}/php:latest \
# --file Dockerfile .

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
# --tag ${IMAGE_NAME}-mysql-${variant}-${codename} \
# --tag ${IMAGE_NAME}-mysql-${variant} \
# --tag ${IMAGE_NAME}-mysql-${codename} \
# --tag ${IMAGE_NAME}-mysql \
# --tag ${DOCKER_NAME}/php:mysql-${codename} \
# --tag ${DOCKER_NAME}/php:mysql \
# --file Dockerfile.mysql .

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
docker build ${IMAGE_BUILD} ${PROXY_SETTINGS} \
--tag ${IMAGE_NAME}-oci-${variant}-${codename} \
--tag ${IMAGE_NAME}-oci-${variant} \
--tag ${IMAGE_NAME}-oci-${codename} \
--tag ${IMAGE_NAME}-oci \
--tag ${DOCKER_NAME}/php:oci-${codename} \
--tag ${DOCKER_NAME}/php:oci \
--file Dockerfile.oracle .

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
# --tag ${IMAGE_NAME}-pgsql-${variant}-${codename} \
# --tag ${IMAGE_NAME}-pgsql-${variant} \
# --tag ${IMAGE_NAME}-pgsql-${codename} \
# --tag ${IMAGE_NAME}-pgsql \
# --tag ${DOCKER_NAME}/php:pgsql-${codename} \
# --tag ${DOCKER_NAME}/php:pgsql \
# --file Dockerfile.pgsql .

# docker push ${IMAGE_NAME}-${variant}-${codename} && \
# docker push ${IMAGE_NAME}-${variant} && \
# docker push ${IMAGE_NAME}-${codename} && \
# docker push ${IMAGE_NAME} && \
# docker push ${DOCKER_NAME}/php:${variant}-${codename} && \
# docker push ${DOCKER_NAME}/php:${variant} && \
# docker push ${DOCKER_NAME}/php:${codename} && \
# docker push ${DOCKER_NAME}/php:latest

# docker push ${IMAGE_NAME}-mysql-${variant}-${codename} && \
# docker push ${IMAGE_NAME}-mysql-${variant} && \
# docker push ${IMAGE_NAME}-mysql-${codename} && \
# docker push ${IMAGE_NAME}-mysql && \
# docker push ${DOCKER_NAME}/php:mysql-${codename} && \
# docker push ${DOCKER_NAME}/php:mysql

docker push ${IMAGE_NAME}-oci-${variant}-${codename} && \
docker push ${IMAGE_NAME}-oci-${variant} && \
docker push ${IMAGE_NAME}-oci-${codename} && \
docker push ${IMAGE_NAME}-oci && \
docker push ${DOCKER_NAME}/php:oci-${codename} && \
docker push ${DOCKER_NAME}/php:oci

# docker push ${IMAGE_NAME}-pgsql-${variant}-${codename} && \
# docker push ${IMAGE_NAME}-pgsql-${variant} && \
# docker push ${IMAGE_NAME}-pgsql-${codename} && \
# docker push ${IMAGE_NAME}-pgsql && \
# docker push ${DOCKER_NAME}/php:pgsql-${codename} && \
# docker push ${DOCKER_NAME}/php:pgsql
