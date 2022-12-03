#INFO_BUILD_DOCKER_TAG = ${ENV_DIST_VERSION}
INFO_BUILD_DOCKER_TAG = latest
INFO_BUILD_DOCKER_FILE = Dockerfile
INFO_REPOSITORY=${ROOT_NAME}
INFO_OWNER=bridgewwater
# if set INFO_PRIVATE_DOCKER_REGISTRY= will push to hub.docker.com
# private docker registry use harbor must create project name as ${INFO_OWNER}
#INFO_PRIVATE_DOCKER_REGISTRY=harbor.xxx.com/
INFO_PRIVATE_DOCKER_REGISTRY=
INFO_BUILD_DOCKER_SOURCE_IMAGE ?= ${INFO_OWNER}/${INFO_REPOSITORY}
INFO_BUILD_FROM_IMAGE ?= alpine:3.17

INFO_TEST_BUILD_DOCKER_FILE ?= Dockerfile.s6
INFO_TEST_BUILD_PARENT_IMAGE ?= golang:1.17.13-buster
INFO_TEST_BUILD_PARENT_CONTAINER ?= "test-parent-${INFO_REPOSITORY}"
INFO_TEST_TAG_BUILD_CONTAINER_NAME ?= "test-${INFO_REPOSITORY}"

## change this for ip-v4 get
#ROOT_LOCAL_IP_V4_LINUX = $$(ifconfig enp8s0 | grep inet | grep -v inet6 | cut -d ':' -f2 | cut -d ' ' -f1)
#ROOT_LOCAL_IP_V4_DARWIN = $$(ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2)
#
#localIPLinux:
#	@echo "=> now run as docker with linux"
#	@echo "local ip address is: $(ROOT_LOCAL_IP_V4_LINUX)"
#
#localIPDarwin:
#	@echo "=> now run as docker with darwin"
#	@echo "local ip address is: $(ROOT_LOCAL_IP_V4_DARWIN)"

dockerEnv:
	@echo "== docker env print start"
	@echo "INFO_REPOSITORY                     ${INFO_REPOSITORY}"
	@echo "INFO_OWNER                          ${INFO_OWNER}"
	@echo "INFO_BUILD_DOCKER_IMAGE_NAME        ${INFO_BUILD_DOCKER_SOURCE_IMAGE}"
	@echo "INFO_BUILD_DOCKER_TAG               ${INFO_BUILD_DOCKER_TAG}"
	@echo "INFO_BUILD_DOCKER_FILE              ${INFO_BUILD_DOCKER_FILE}"
	@echo "INFO_BUILD_FROM_IMAGE               ${INFO_BUILD_FROM_IMAGE}"
	@echo "INFO_PRIVATE_DOCKER_REGISTRY        ${INFO_PRIVATE_DOCKER_REGISTRY}"
	@echo "REGISTRY tag as:                    ${INFO_PRIVATE_DOCKER_REGISTRY}${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}"
	@echo ""
	@echo "INFO_TEST_BUILD_PARENT_IMAGE        ${INFO_TEST_BUILD_PARENT_IMAGE}"
	@echo "INFO_TEST_BUILD_PARENT_CONTAINER    ${INFO_TEST_BUILD_PARENT_CONTAINER}"
	@echo ""
	@echo "INFO_TEST_TAG_BUILD_CONTAINER_NAME  ${INFO_TEST_TAG_BUILD_CONTAINER_NAME}"
	@echo ""
	@echo "== docker env print end"

dockerAllPull:
	docker pull ${INFO_BUILD_FROM_IMAGE}
	docker pull ${INFO_TEST_BUILD_PARENT_IMAGE}

dockerCleanImages:
	(while :; do echo 'y'; sleep 3; done) | docker image prune

dockerCleanPruneAll:
	(while :; do echo 'y'; sleep 3; done) | docker container prune
	(while :; do echo 'y'; sleep 3; done) | docker image prune

dockerRunContainerParentBuild:
	@echo "run rm container image: ${INFO_TEST_BUILD_PARENT_IMAGE}"
	# docker run -d --rm --name ${INFO_TEST_BUILD_PARENT_CONTAINER} ${INFO_TEST_BUILD_PARENT_IMAGE}
	docker run -d --rm --name ${INFO_TEST_BUILD_PARENT_CONTAINER} ${INFO_TEST_BUILD_PARENT_IMAGE} tail -f /dev/null
	@echo ""
	@echo "-> run rm container name: ${INFO_TEST_BUILD_PARENT_CONTAINER}"
	@echo "-> into container use: docker exec -it ${INFO_TEST_BUILD_PARENT_CONTAINER} bash"

dockerRmContainerParentBuild:
	-docker rm -f ${INFO_TEST_BUILD_PARENT_CONTAINER}

dockerPruneContainerParentBuild: dockerRmContainerParentBuild
	-docker rmi -f ${INFO_TEST_BUILD_PARENT_IMAGE}

dockerTestBuildLatest:
	docker build --rm=true --tag ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG} --file ${INFO_TEST_BUILD_DOCKER_FILE} .

dockerTestRunLatest:
	docker image inspect --format='{{ .Created}}' ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}
	-docker run --rm --name ${INFO_TEST_TAG_BUILD_CONTAINER_NAME} \
	-e RUN_MODE=dev \
	${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}
	# for inner check can use like this
	# docker run -it -d --entrypoint /bin/sh --name ${INFO_TEST_TAG_BUILD_CONTAINER_NAME} ${INFO_TEST_TAG_BUILD_IMAGE_NAME}:${INFO_BUILD_DOCKER_TAG}
	-docker inspect --format='{{ .State.Status}}' ${INFO_TEST_TAG_BUILD_CONTAINER_NAME}

dockerTestLogLatest:
	-docker logs ${INFO_TEST_TAG_BUILD_CONTAINER_NAME}

dockerTestRmLatest:
	-docker rm -f ${INFO_TEST_TAG_BUILD_CONTAINER_NAME}

dockerTestRmiLatest:
	-INFO_TEST_TAG_BUILD_CONTAINER_NAME=$(INFO_TEST_TAG_BUILD_CONTAINER_NAME) \
	INFO_TEST_TAG_BUILD_IMAGE_NAME=$(INFO_BUILD_DOCKER_SOURCE_IMAGE) \
	ROOT_DOCKER_IMAGE_TAG=$(INFO_BUILD_DOCKER_TAG) \
	INFO_BUILD_DOCKER_TAG=${INFO_BUILD_DOCKER_TAG} \
	docker rmi -f ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}

dockerTestRestartLatest: dockerTestRmLatest dockerTestRmiLatest dockerTestBuildLatest dockerTestRunLatest
	@echo "restart ${INFO_TEST_TAG_BUILD_CONTAINER_NAME} ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}"

dockerTestStopLatest: dockerTestRmLatest dockerTestRmiLatest
	@echo "stop and remove ${INFO_TEST_TAG_BUILD_CONTAINER_NAME} ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}"

dockerTestPruneLatest: dockerTestStopLatest
	@echo "prune and remove ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}"

dockerRmiBuild:
	-docker rmi -f ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}
	-docker rmi -f ${INFO_PRIVATE_DOCKER_REGISTRY}${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}

dockerBuild:
	docker build --rm=true --tag ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG} --file ${INFO_BUILD_DOCKER_FILE} .

dockerTag:
	docker tag ${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG} ${INFO_PRIVATE_DOCKER_REGISTRY}${INFO_BUILD_DOCKER_SOURCE_IMAGE}

dockerBeforePush: dockerRmiBuild dockerBuild dockerTag
	@echo "===== then now can push to ${INFO_PRIVATE_DOCKER_REGISTRY}"

dockerPushBuild: dockerBeforePush
	docker push ${INFO_PRIVATE_DOCKER_REGISTRY}${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}
	@echo "=> push ${INFO_PRIVATE_DOCKER_REGISTRY}${INFO_BUILD_DOCKER_SOURCE_IMAGE}:${INFO_BUILD_DOCKER_TAG}"

helpDocker:
	@echo "=== this make file can include MakeDocker.mk then use"
	@echo "- must has file: [ ${INFO_BUILD_DOCKER_FILE} ${INFO_TEST_BUILD_DOCKER_FILE}" ]
	@echo "- then change tag as:                       INFO_BUILD_DOCKER_TAG"
	@echo "- then change repository as:                INFO_REPOSITORY"
	@echo "- then change owner as:                     INFO_OWNER"
	@echo "- then change private docker repository as: INFO_PRIVATE_DOCKER_REGISTRY"
	@echo "- then change build parent image as:        INFO_TEST_BUILD_PARENT_IMAGE"
	@echo "- then change build image as:               INFO_BUILD_FROM_IMAGE"
	@echo "- check by task"
	@echo "$$ make dockerEnv"
	@echo ""
	@echo "- first use can pull images"
	@echo "$$ make dockerAllPull"
	@echo ""
	@echo "- then use to show how to build docker parent image"
	@echo "$$ make dockerRunContainerParentBuild"
	@echo "- and prune resource at parent image"
	@echo "$$ make dockerPruneContainerParentBuild"
	@echo ""
	@echo "- test run container use ./${INFO_TEST_BUILD_DOCKER_FILE}"
	@echo "$$ make dockerTestRestartLatest"
	@echo "- prune test container and image"
	@echo "$$ make dockerTestPruneLatest"
	@echo ""
	@echo "- build and tag as use ./${INFO_BUILD_DOCKER_FILE}"
	@echo "$$ make dockerBeforePush"
	@echo "- prune build"
	@echo "$$ make dockerRmiBuild"
	@echo "- then final push use"
	@echo "$$ make dockerPushBuild"