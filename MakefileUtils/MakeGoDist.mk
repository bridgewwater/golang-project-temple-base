# this file must use as base Makefile job must has variate
#
# must as some include MakeDistTools.mk
#
# INFO_ROOT_DIST_PATH for set make go dist path
# ENV_ROOT_BUILD_BIN_NAME for set go binary file name
# ENV_DIST_VERSION for set dist version name
# ENV_DIST_MARK for set dist version mark
# ENV_DIST_GO_OS for set go build GOOS
# ENV_DIST_GO_ARCH for set go build GOARCH
#
# task: [ cleanAllDist ] can clean dist
# task: [ helpDist distEnv ] can show more info

ENV_SERVER_TEST_SSH_ALIAS = aliyun-ecs
ENV_SERVER_TEST_FOLDER = /home/work/Document/
ENV_SERVER_REPO_SSH_ALIAS = golang-project-temple-base
ENV_SERVER_REPO_FOLDER = /home/ubuntu/$(ROOT_NAME)

ENV_INFO_DIST_BIN_NAME=${ENV_ROOT_BUILD_BIN_NAME}
ENV_INFO_DIST_VERSION=${ENV_DIST_VERSION}
ENV_INFO_DIST_MARK=${ENV_DIST_MARK}
ENV_INFO_DIST_BUILD_ENTRANCE=${ENV_ROOT_BUILD_ENTRANCE}
ENV_INFO_DIST_GO_OS=${ENV_DIST_GO_OS}
ENV_INFO_DIST_GO_ARCH=${ENV_DIST_GO_ARCH}
ENV_INFO_DIST_ENV_TEST_NAME=test
ENV_INFO_DIST_ENV_RELEASE_NAME=release


define dist_tar_with_source
	@echo "=> start $(0)"
ifeq ($(OS),Windows_NT)
	target_tar_folder=$(subst /,\,$(1))
	target_tar_gz_path=$(subst /,\,$(3)/${ENV_INFO_DIST_BIN_NAME}-$(2)-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}).tar.gz
	target_tar_sum_path=$(subst /,\,$(3)/${ENV_INFO_DIST_BIN_NAME}-$(2)-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}).tar.gz.sha256
else
	target_tar_folder=$(1)
	target_tar_gz_path=$(3)/${ENV_INFO_DIST_BIN_NAME}-$(2)-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz
	target_tar_sum_path=$(3)/${ENV_INFO_DIST_BIN_NAME}-$(2)-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz.sha256
endif
	@echo " want tar target folder   : ${target_tar_folder}"
	@echo "      tar env string      : $(2)"
	@echo "      tar source folder   : $(subst /,\,$(3))"
	@echo ""
	@echo " if cp source can change here"
	@echo ""
	@echo " want  tar as: ${target_tar_gz_path}"
	@echo " check tar as ${target_tar_sum_path}"

	@tar zcvf ${target_tar_gz_path} -C ${target_tar_folder} .
	@shasum -a 256 ${target_tar_gz_path} > ${target_tar_sum_path}
	@echo "-> check as: tar -tf ${target_tar_gz_path}"
	@echo "~> tar ${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK} at: ${target_tar_gz_path}"
endef

distEnv:
	@echo "== MakeGoDist info start =="
	@echo ""
	@echo "ENV_PATH_INFO_ROOT_DIST                   ${ENV_PATH_INFO_ROOT_DIST}"
	@echo "ENV_INFO_DIST_BIN_NAME                    ${ENV_INFO_DIST_BIN_NAME}"
	@echo "ENV_INFO_DIST_VERSION                     ${ENV_INFO_DIST_VERSION}"
	@echo "ENV_INFO_DIST_MARK                        ${ENV_INFO_DIST_MARK}"
	@echo "ENV_INFO_DIST_BUILD_ENTRANCE              ${ENV_INFO_DIST_BUILD_ENTRANCE}"
	@echo ""
	@echo "ENV_INFO_DIST_GO_OS                       ${ENV_INFO_DIST_GO_OS}"
	@echo "ENV_INFO_DIST_GO_ARCH                     ${ENV_INFO_DIST_GO_ARCH}"
	@echo ""
	@echo "== MakeGoDist info end   =="
	@echo ""

cleanAllDist: cleanDistAll
	@echo "~> finish clean path: ${ENV_PATH_INFO_ROOT_DIST}"

define go_local_binary_dist
	@echo "=> start $(0)"
	@echo " want build mark run env       : ${1}"
	@echo "      build out at path        : ${2}"
	@echo "      build out binary path    : ${3}"
	@echo "      build entrance           : ${4}"
	go build -o ${3} ${4}
	@echo "go local binary out at: ${3}"
endef

define go_static_binary_dist
	@echo "=> start $(0)"
	@echo " want build out at path    : $(1)"
	@echo "      build mark run env   : $(2)"
	@echo "      build out binary     : $(3)"
	@echo "      build GOOS           : $(4)"
	@echo "      build GOARCH         : $(5)"
	@echo "      build entrance       : ${ENV_INFO_DIST_BUILD_ENTRANCE}"
	@echo "      DIST_BUILD_BIN_PATH  : $(1)/os/$(4)/$(5)/$(2)/$(3)"
	@if [ ! -d $(1)/os/$(4)/$(5)/$(2) ]; \
	then mkdir -p $(1)/os/$(4)/$(5)/$(2) && echo "~> mkdir $(1)/os/$(4)/$(5)/$(2)"; \
	else \
	rm -rf $(1)/os/$(4)/$(5)/$(2)/* ; \
	fi
	@echo "-> start build OS:$(4) ARCH:$(5)"
	GOOS=$(4) GOARCH=$(5) go build \
	-a \
	-tags netgo \
	-ldflags '-w -s --extldflags "-static -fpic"' \
	-o $(1)/os/$(4)/$(5)/$(2)/$(3) ${ENV_INFO_DIST_BUILD_ENTRANCE}
	@echo "=> end $(1)/os/$(4)/$(5)/$(2)/$(3)"
endef

distTest: cleanRootDistLocalTest pathCheckRootDistLocalTest
ifeq ($(OS),Windows_NT)
	$(call go_local_binary_dist,\
	${ENV_INFO_DIST_ENV_TEST_NAME},\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}/${ENV_INFO_DIST_BIN_NAME}.exe),\
	${ENV_INFO_DIST_BUILD_ENTRANCE})
else
	$(call go_local_binary_dist,\
	${ENV_INFO_DIST_ENV_TEST_NAME},\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST},\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}/${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_DIST_BUILD_ENTRANCE})
endif

distTestTar: distTest
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/local/${ENV_INFO_DIST_ENV_TEST_NAME},${ENV_INFO_DIST_ENV_TEST_NAME},${INFO_ROOT_DIST_PATH}/local)

distTestOS:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_TEST_NAME},${ENV_INFO_DIST_BIN_NAME},${ENV_INFO_DIST_GO_OS},${ENV_INFO_DIST_GO_ARCH})

distTestOSTar: distTestOS
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_ENV_TEST_NAME},${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}-${ENV_INFO_DIST_ENV_TEST_NAME},${INFO_ROOT_DIST_PATH}/os)

distScpTestOSTar: distTestOSTar
	#scp ${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_BIN_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}-${ENV_INFO_DIST_ENV_TEST_NAME}-${ENV_INFO_DIST_VERSION}${ENV_DIST_MARK}.tar.gz ${ENV_SERVER_TEST_SSH_ALIAS}:${ENV_SERVER_TEST_FOLDER}
	@echo "=> must check below config of set for release OS Scp"

distRelease:
	$(call go_local_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME})

distReleaseTar: distRelease
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/local/${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/local)

distReleaseOS:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},${ENV_INFO_DIST_GO_OS},${ENV_INFO_DIST_GO_ARCH})

distReleaseOSTar: distReleaseOS
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distScpReleaseOSTar: distReleaseOSTar
	#scp ${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_BIN_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}-${ENV_INFO_DIST_ENV_RELEASE_NAME}-${ENV_INFO_DIST_VERSION}${ENV_DIST_MARK}.tar.gz ${ENV_SERVER_REPO_SSH_ALIAS}:${ENV_SERVER_REPO_FOLDER}
	@echo "=> must check below config of set for release OS Scp"

distAllLocalTar: distTestTar distReleaseTar
	@echo "=> all dist as os tar finish"

distAllOsTar: distTestOSTar distReleaseOSTar
	@echo "=> all dist as os tar finish"

distAllTar: distAllLocalTar distAllOsTar
	@echo "=> all dist tar has finish"

distPlatformTarWinAmd64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME}.exe,windows,amd64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/windows/amd64/${ENV_INFO_DIST_ENV_RELEASE_NAME},windows-amd64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarWin386:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME}.exe,windows,386)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/windows/386/${ENV_INFO_DIST_ENV_RELEASE_NAME},windows-386-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarWinArm64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME}.exe,windows,arm64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/windows/arm64/${ENV_INFO_DIST_ENV_RELEASE_NAME},windows-arm64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarWinArm:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME}.exe,windows,arm)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/windows/arm/${ENV_INFO_DIST_ENV_RELEASE_NAME},windows-arm-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarAllWindows: distPlatformTarWinAmd64 distPlatformTarWin386 distPlatformTarWinArm64 distPlatformTarWinArm

distPlatformTarLinuxAmd64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},linux,amd64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/linux/amd64/${ENV_INFO_DIST_ENV_RELEASE_NAME},linux-amd64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarLinux386:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},linux,386)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/linux/386/${ENV_INFO_DIST_ENV_RELEASE_NAME},linux-386-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarLinuxArm64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},linux,arm64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/linux/arm64/${ENV_INFO_DIST_ENV_RELEASE_NAME},linux-arm64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarLinuxArm:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},linux,arm)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/linux/arm/${ENV_INFO_DIST_ENV_RELEASE_NAME},linux-arm-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarAllLinux: distPlatformTarLinuxAmd64 distPlatformTarLinux386 distPlatformTarLinuxArm64 distPlatformTarLinuxArm

distPlatformTarMacosAmd64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},darwin,amd64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/darwin/amd64/${ENV_INFO_DIST_ENV_RELEASE_NAME},darwin-amd64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarMacosArm64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},darwin,arm64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/darwin/arm64/${ENV_INFO_DIST_ENV_RELEASE_NAME},darwin-arm64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarAllMacos: distPlatformTarMacosAmd64 distPlatformTarMacosArm64

distPlatformTarFreebsdAmd64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},freebsd,amd64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/freebsd/amd64/${ENV_INFO_DIST_ENV_RELEASE_NAME},freebsd-amd64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarFreebsd386:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},freebsd,386)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/freebsd/386/${ENV_INFO_DIST_ENV_RELEASE_NAME},freebsd-386-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarFreebsdArm64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},freebsd,arm64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/freebsd/arm64/${ENV_INFO_DIST_ENV_RELEASE_NAME},freebsd-arm64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarFreebsdArm:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},freebsd,arm)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/freebsd/arm/${ENV_INFO_DIST_ENV_RELEASE_NAME},freebsd-arm-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarAllFreebsd: distPlatformTarFreebsdAmd64 distPlatformTarFreebsd386 distPlatformTarFreebsdArm64 distPlatformTarFreebsdArm

distPlatformTarOpenbsdAmd64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},openbsd,amd64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/openbsd/amd64/${ENV_INFO_DIST_ENV_RELEASE_NAME},openbsd-amd64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarOpenbsd386:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},openbsd,386)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/openbsd/386/${ENV_INFO_DIST_ENV_RELEASE_NAME},openbsd-386-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarOpenbsdArm64:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},openbsd,arm64)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/openbsd/arm64/${ENV_INFO_DIST_ENV_RELEASE_NAME},openbsd-arm64-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarOpenbsdArm:
	$(call go_static_binary_dist,${INFO_ROOT_DIST_PATH},${ENV_INFO_DIST_ENV_RELEASE_NAME},${ENV_INFO_DIST_BIN_NAME},openbsd,arm)
	$(call dist_tar_with_source,${INFO_ROOT_DIST_PATH}/os/openbsd/arm/${ENV_INFO_DIST_ENV_RELEASE_NAME},openbsd-arm-${ENV_INFO_DIST_ENV_RELEASE_NAME},${INFO_ROOT_DIST_PATH}/os)

distPlatformTarAllOpenbsd: distPlatformTarOpenbsdAmd64 distPlatformTarOpenbsd386 distPlatformTarOpenbsdArm64 distPlatformTarOpenbsdArm

distPlatformTarCommonUse: distPlatformTarLinuxAmd64 distPlatformTarWinAmd64 distPlatformTarMacosAmd64 distPlatformTarMacosArm64

distPlatformTarAll: distPlatformTarAllLinux distPlatformTarAllMacos distPlatformTarAllWindows distPlatformTarAllFreebsd distPlatformTarAllOpenbsd

helpDist:
	@echo "Help: helpDist.mk"
	@echo "-- distTestOS or distReleaseOS will out abi as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH) --"
	@echo "~> make cleanAllDist             - clean all dist at $(INFO_ROOT_DIST_PATH)"
	@echo "~> make distTest                 - build dist at ${INFO_ROOT_DIST_PATH}/local/${ENV_INFO_DIST_ENV_TEST_NAME} in local OS"
	@echo "~> make distTestTar              - build dist at ${INFO_ROOT_DIST_PATH}/local/${ENV_INFO_DIST_ENV_TEST_NAME} in local OS and tar"
	@echo "~> make distTestOS               - build dist at ${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_ENV_TEST_NAME} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH)"
	@echo "~> make distTestOSTar            - build dist at ${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_ENV_TEST_NAME} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH) and tar"
	@echo "~> make distRelease              - build dist at ${INFO_ROOT_DIST_PATH}/local/${ENV_INFO_DIST_ENV_RELEASE_NAME} in local OS"
	@echo "~> make distReleaseTar           - build dist at ${INFO_ROOT_DIST_PATH}/local/${ENV_INFO_DIST_ENV_RELEASE_NAME} in local OS and tar"
	@echo "~> make distReleaseOS            - build dist at ${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_ENV_RELEASE_NAME} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH)"
	@echo "~> make distReleaseOSTar         - build dist at ${INFO_ROOT_DIST_PATH}/os/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_ENV_RELEASE_NAME} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH) and tar"
	@echo "~> make distAllTar               - build all tar to dist"
	@echo "~> make distPlatformTarCommonUse - build tar to dist linux-amd64 win-amd64 macOS-amd64 macOS-arm64"
	@echo "~> make distPlatformTarAll       - build all platform tar to dist and tar"
	@echo ""
