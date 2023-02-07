# this file must use as base Makefile job must has variate
#
# must as some include MakeDistTools.mk
#
# windows use must install tools
# https://scoop.sh/#/apps?q=busybox&s=0&d=1&o=true
# scoop install shasum
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

ENV_SERVER_TEST_SSH_ALIAS=aliyun-ecs
ENV_SERVER_TEST_FOLDER=/home/work/Document/
ENV_SERVER_REPO_SSH_ALIAS=golang-project-temple-base
ENV_SERVER_REPO_FOLDER=/home/ubuntu/$(ROOT_NAME)

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
	@echo " want tar source folder     : $(strip ${1})"
	@echo "      tar file full folder  : $(strip ${2})"
	@echo "      tar file env          : $(strip ${3})"
	@echo "      tar file full path    : $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
	@echo "      ENV_INFO_DIST_VERSION : ${ENV_INFO_DIST_VERSION}"
	@echo "      ENV_INFO_DIST_MARK    : ${ENV_INFO_DIST_MARK}"
	@echo ""
	@echo " if cp source can change here"
	@echo ""

	tar -zcvf $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz -C $(strip ${1}) "."
	shasum -a 256 $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz > $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz.sha256
	@echo "-> check as: tar -tf $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
	@echo "~> tar ${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK} at: $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
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
	@echo " want build mark run env       : $(${1})"
	@echo "      build out at path        : $(${2})"
	@echo "      build out binary path    : $(${3})"
	@echo "      build entrance           : $(strip ${4})"
	go build -o $(strip ${3}) $(strip ${4})
	@echo "go local binary out at: $(strip ${3})"
endef

define go_static_binary_dist
	@echo "=> start $(0)"
	@echo " want build out at path        : $(strip $(1))"
	@echo "      build mark run env       : $(strip $(2))"
	@echo "      build out binary         : $(strip $(3))"
	@echo "      build GOOS               : $(strip $(4))"
	@echo "      build GOARCH             : $(strip $(5))"
	@echo "      build entrance           : $(strip ${ENV_INFO_DIST_BUILD_ENTRANCE})"
	@echo "      DIST_BUILD_BIN_PATH      : $(strip $(6))"
	@echo "-> start build OS:$(strip $(4)) ARCH:$(strip $(5))"
	GOOS=$(strip $(4)) GOARCH=$(strip $(5)) go build \
	-a \
	-tags netgo \
	-ldflags '-w -s --extldflags "-static -fpic"' \
	-o $(strip $(6)) $(strip ${ENV_INFO_DIST_BUILD_ENTRANCE})
	@echo "=> end $(strip $(6))"
endef

define go_static_binary_windows_dist
	@echo "=> start $(0)"
$(warning "-> windows make shell cross compiling may be take mistake")
	@echo " want build out at path        : $(strip $(1))"
	@echo "      build mark run env       : $(strip $(2))"
	@echo "      build out binary         : $(strip $(3))"
	@echo "      build GOOS               : $(strip $(4))"
	@echo "      build GOARCH             : $(strip $(5))"
	@echo "      build entrance           : $(strip ${ENV_INFO_DIST_BUILD_ENTRANCE})"
	@echo "      DIST_BUILD_BIN_PATH      : $(strip $(6))"
	@echo "-> start build OS:$(strip $(4)) ARCH:$(strip $(5))"
	set GOOS=$(strip $(4)); set GOARCH=$(strip $(5)); go build \
	-a \
	-tags netgo \
	-ldflags '-w -s --extldflags "-static"' \
	-o $(strip $(6)).exe $(strip ${ENV_INFO_DIST_BUILD_ENTRANCE})
	@echo "=> end $(strip $(6))"
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
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_source,\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}/),\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL}/),\
	${ENV_INFO_DIST_ENV_TEST_NAME}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}/,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL}/,\
	${ENV_INFO_DIST_ENV_TEST_NAME}\
	)
endif

distTestOS: pathCheckRootDistOs
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_TEST_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_TEST_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif

distTestOSTar: distTestOS
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_source,\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}),\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}),\
	${ENV_INFO_DIST_ENV_TEST_NAME}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_TEST_NAME}\
	)
endif

distScpTestOSTar: distTestOSTar
	#scp ${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_BIN_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}-${ENV_INFO_DIST_ENV_TEST_NAME}-${ENV_INFO_DIST_VERSION}${ENV_DIST_MARK}.tar.gz ${ENV_SERVER_TEST_SSH_ALIAS}:${ENV_SERVER_TEST_FOLDER}
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
