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
# --tag ${IMAGE_NAME}-${variant}-${codename} \
# --tag ${IMAGE_NAME}-${variant} \
# --tag ${DOCKER_NAME}/php:${variant}-${codename} \
# --tag ${DOCKER_NAME}/php:${variant} \
# --file Dockerfile .

docker image rm --force ${IMAGE_NAME}-oci-${variant}-${codename} \
${IMAGE_NAME}-oci-${variant} \
${DOCKER_NAME}/php:oci-${variant}-${codename} \
${DOCKER_NAME}/php:oci-${variant}

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
docker build ${IMAGE_BUILD} ${PROXY_SETTINGS} \
--tag ${IMAGE_NAME}-oci-${variant}-${codename} \
--tag ${IMAGE_NAME}-oci-${variant} \
--tag ${DOCKER_NAME}/php:oci-${variant}-${codename} \
--tag ${DOCKER_NAME}/php:oci-${variant} \
--file Dockerfile.oracle .

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
# --tag ${IMAGE_NAME}-mysql-${variant}-${codename} \
# --tag ${IMAGE_NAME}-mysql-${variant} \
# --tag ${DOCKER_NAME}/php:mysql-${variant}-${codename} \
# --tag ${DOCKER_NAME}/php:mysql-${variant} \
# --file Dockerfile.mysql .

# docker build --force-rm --no-cache ${IMAGE_BUILD} ${PROXY_SETTINGS} \
# --tag ${IMAGE_NAME}-pgsql-${variant}-${codename} \
# --tag ${IMAGE_NAME}-pgsql-${variant} \
# --tag ${DOCKER_NAME}/php:pgsql-${variant}-${codename} \
# --tag ${DOCKER_NAME}/php:pgsql-${variant} \
# --file Dockerfile.pgsql .

# docker push ${IMAGE_NAME}-${variant}-${codename} && \
# docker push ${IMAGE_NAME}-${variant} && \
# docker push ${DOCKER_NAME}/php:${variant}-${codename} && \
# docker push ${DOCKER_NAME}/php:${variant}

docker push ${IMAGE_NAME}-oci-${variant}-${codename} && \
docker push ${IMAGE_NAME}-oci-${variant}
docker push ${DOCKER_NAME}/php:oci-${variant}-${codename} && \
docker push ${DOCKER_NAME}/php:oci-${variant}

# docker push ${IMAGE_NAME}-mysql-${variant}-${codename} && \
# docker push ${IMAGE_NAME}-mysql-${variant}
# docker push ${DOCKER_NAME}/php:mysql-${variant}-${codename} && \
# docker push ${DOCKER_NAME}/php:mysql-${variant}

# docker push ${IMAGE_NAME}-pgsql-${variant}-${codename} && \
# docker push ${IMAGE_NAME}-pgsql-${variant}
# docker push ${DOCKER_NAME}/php:pgsql-${variant}-${codename} && \
# docker push ${DOCKER_NAME}/php:pgsql-${variant}