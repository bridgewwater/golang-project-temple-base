## for golang test task
# include z-MakefileUtils/MakeGoDist.mk
# this file must use as base Makefile job must has variate
#
# must as some include MakeDistTools.mk
#
# windows use must install tools
# https://scoop.sh/#/apps?q=busybox&s=0&d=1&o=true
# scoop install main/busybox
# https://scoop.sh/#/apps?q=shasum&s=0&d=1&o=true
# scoop install main/shasum
#
# ENV_ROOT_BUILD_BIN_NAME for set go binary file name
# ENV_DIST_VERSION for set dist version name
# ENV_DIST_MARK for set dist version mark
# ENV_DIST_GO_OS for set go build GOOS
# ENV_DIST_GO_ARCH for set go build GOARCH
#
# task: [ cleanAllDist ] can clean dist
# task: [ helpDist distEnv ] can show more info

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
	@echo "      tar file abs folder   : $(strip ${2})"
	@echo "      tar file env mark     : $(strip ${3})"
	@echo "      tar file full path    : $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
	@echo "      ENV_INFO_DIST_VERSION : ${ENV_INFO_DIST_VERSION}"
	@echo "      ENV_INFO_DIST_MARK    : ${ENV_INFO_DIST_MARK}"
	@echo ""
	$(warning if cp source can change here cp tar undper $(strip ${1}))
	$(info change this - cp '${ENV_ROOT_MANIFEST_PKG_JSON}' '$(strip ${1})')
	$(info change this - cp -R 'doc/' '$(strip ${1})/doc')
	cp -R 'doc/' '$(strip ${1})/doc'
	@echo "-> cp source finish"

	tar -zcvf $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz -C $(strip ${1}) "."
	shasum -a 256 $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz > $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz.sha256
	@echo "-> check as: tar -tf $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
	@echo "~> tar ${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK} at: $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
endef

define dist_tar_with_windows_source
	@echo "=> start $(0)"
	@echo " want tar source folder     : $(subst /,\,$(strip ${1}))"
	@echo "      tar file abs folder   : $(strip ${2})"
	@echo "      tar file env mark     : $(strip ${3})"
	@echo "      tar file full path    : $(strip ${2})${ENV_INFO_DIST_BIN_NAME}-$(strip ${3})-${ENV_INFO_DIST_VERSION}${ENV_INFO_DIST_MARK}.tar.gz"
	@echo "      ENV_INFO_DIST_VERSION : ${ENV_INFO_DIST_VERSION}"
	@echo "      ENV_INFO_DIST_MARK    : ${ENV_INFO_DIST_MARK}"
	@echo ""
	$(warning if cp source can change here cp tar undper $(strip ${1}))
	$(info change this - cp '${ENV_ROOT_MANIFEST_PKG_JSON}' '$(strip ${1})')
	$(info change this - cp -R 'doc\' '$(strip ${1})\')
	cp -R 'doc\' '$(strip ${1})\'
	@echo "-> cp source finish"

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
	@echo " want build mark run env       : $(strip ${1})"
	@echo "      build out at path        : $(strip ${2})"
	@echo "      build out binary path    : $(strip ${3})"
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
	set GOOS=$(strip $(4))
	set GOARCH=$(strip $(5))
	go build \
	-a \
	-tags netgo \
	-ldflags '-w -s --extldflags "-static"' \
	-o $(strip $(6)) $(strip ${ENV_INFO_DIST_BUILD_ENTRANCE})
	@echo "=> end $(strip $(6)).exe"
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
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}/,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL}/,\
	${ENV_INFO_DIST_ENV_TEST_NAME}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}/,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL}/,\
	${ENV_INFO_DIST_ENV_TEST_NAME}\
	)
endif

distTestOS: cleanRootDistOs pathCheckRootDistOs
ifeq (${ENV_INFO_DIST_GO_OS},${ENV_INFO_PLATFORM_OS_WINDOWS})
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_TEST_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME}).exe\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_TEST_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME}.exe\
	)
endif
else
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
endif

distTestOSTar: distTestOS
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_DIST_ENV_TEST_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_DIST_ENV_TEST_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}\
	)
endif

distRelease: cleanRootDistLocalRelease pathCheckRootDistLocalRelease
ifeq ($(OS),Windows_NT)
	$(call go_local_binary_dist,\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}/${ENV_INFO_DIST_BIN_NAME}.exe),\
	${ENV_INFO_DIST_BUILD_ENTRANCE})
else
	$(call go_local_binary_dist,\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE},\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}/${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_DIST_BUILD_ENTRANCE})
endif

distReleaseTar: distRelease
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}/,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL}/,\
	${ENV_INFO_DIST_ENV_RELEASE_NAME}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}/,\
	${ENV_PATH_INFO_ROOT_DIST_LOCAL}/,\
	${ENV_INFO_DIST_ENV_RELEASE_NAME}\
	)
endif

distReleaseOS: cleanRootDistOs pathCheckRootDistOs
ifeq (${ENV_INFO_DIST_GO_OS},${ENV_INFO_PLATFORM_OS_WINDOWS})
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME}).exe\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME}.exe\
	)
endif
else
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_DIST_GO_OS},\
	${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
endif

distReleaseOSTar: distReleaseOS
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_DIST_ENV_RELEASE_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_DIST_GO_OS}/${ENV_INFO_DIST_GO_ARCH},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_DIST_ENV_RELEASE_NAME}-${ENV_INFO_DIST_GO_OS}-${ENV_INFO_DIST_GO_ARCH}\
	)
endif

distAllLocalTar: distTestTar distReleaseTar
	@echo "=> all dist as os tar finish"

distPlatformTarWinAmd64: cleanRootDistPlatformWinAmd64 pathCheckRootDistPlatformWinAmd64
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}/${ENV_INFO_DIST_BIN_NAME}).exe\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}/${ENV_INFO_DIST_BIN_NAME}.exe\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_AMD64}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_AMD64}\
	)
endif

distPlatformTarWin386: cleanRootDistPlatformWin386 pathCheckRootDistPlatformWin386
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_386},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_386}/${ENV_INFO_DIST_BIN_NAME}).exe\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_386},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_386}/${ENV_INFO_DIST_BIN_NAME}.exe\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_386},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_386}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_386},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_386}\
	)
endif

distPlatformTarWinArm64: cleanRootDistPlatformWinArm64 pathCheckRootDistPlatformWinArm64
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}/${ENV_INFO_DIST_BIN_NAME}).exe\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}/${ENV_INFO_DIST_BIN_NAME}.exe\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_ARM64}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_ARM64}\
	)
endif

distPlatformTarWinArm: cleanRootDistPlatformWinArm pathCheckRootDistPlatformWinArm
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM}/${ENV_INFO_DIST_BIN_NAME}).exe\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME}.exe,\
	${ENV_INFO_PLATFORM_OS_WINDOWS},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM}/${ENV_INFO_DIST_BIN_NAME}.exe\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_ARM}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_WINDOWS}-${ENV_INFO_PLATFORM_OS_ARCH_ARM}\
	)
endif

distPlatformTarAllWindows: distPlatformTarWinAmd64 distPlatformTarWin386 distPlatformTarWinArm64 distPlatformTarWinArm

distPlatformTarLinuxAmd64: cleanRootDistPlatformLinuxAmd64 pathCheckRootDistPlatformLinuxAmd64
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_AMD64}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_AMD64}\
	)
endif

distPlatformTarLinux386: cleanRootDistPlatformLinuxAmd386 pathCheckRootDistPlatformLinux386
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_386},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_386}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_386},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_386}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_386},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_386}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_386},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_386}\
	)
endif

distPlatformTarLinuxArm64: cleanRootDistPlatformLinuxArm64 pathCheckRootDistPlatformLinuxArm64
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_ARM64}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_ARM64}\
	)
endif

distPlatformTarLinuxArm: cleanRootDistPlatformLinuxArm pathCheckRootDistPlatformLinuxArm
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_LINUX},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_ARM}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_LINUX}-${ENV_INFO_PLATFORM_OS_ARCH_ARM}\
	)
endif

distPlatformTarAllLinux: distPlatformTarLinuxAmd64 distPlatformTarLinux386 distPlatformTarLinuxArm64 distPlatformTarLinuxArm

distPlatformTarMacosAmd64: cleanRootDistPlatformMacOsAmd64 pathCheckRootDistPlatformMacOsAmd64
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_MACOS},\
	${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_MACOS},\
	${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_MACOS}-${ENV_INFO_PLATFORM_OS_ARCH_AMD64}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_MACOS}-${ENV_INFO_PLATFORM_OS_ARCH_AMD64}\
	)
endif

distPlatformTarMacosArm64: cleanRootDistPlatformMacOsArm64 pathCheckRootDistPlatformMacOsArm64
ifeq ($(OS),Windows_NT)
	$(call go_static_binary_windows_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_MACOS},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	$(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}/${ENV_INFO_DIST_BIN_NAME})\
	)
else
	$(call go_static_binary_dist,\
	${ENV_PATH_INFO_ROOT_DIST_OS},\
	${ENV_INFO_DIST_ENV_RELEASE_NAME},\
	${ENV_INFO_DIST_BIN_NAME},\
	${ENV_INFO_PLATFORM_OS_MACOS},\
	${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}/${ENV_INFO_DIST_BIN_NAME}\
	)
endif
ifeq ($(OS),Windows_NT)
	$(call dist_tar_with_windows_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_MACOS}-${ENV_INFO_PLATFORM_OS_ARCH_ARM64}\
	)
else
	$(call dist_tar_with_source,\
	${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64},\
	${ENV_PATH_INFO_ROOT_DIST_OS}/,\
	${ENV_INFO_PLATFORM_OS_MACOS}-${ENV_INFO_PLATFORM_OS_ARCH_ARM64}\
	)
endif

distPlatformTarAllMacos: distPlatformTarMacosAmd64 distPlatformTarMacosArm64

distPlatformTarCommonUse: distPlatformTarLinuxAmd64 distPlatformTarWinAmd64 distPlatformTarMacosAmd64 distPlatformTarMacosArm64

distPlatformTarAll: distPlatformTarAllLinux distPlatformTarAllMacos distPlatformTarAllWindows

helpGoDist:
	@echo "Help: MakeGoDist.mk"
	@echo "-- distTestOS or distReleaseOS will out abi as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH) --"
	@echo "~> make cleanAllDist             - clean all dist at $(ENV_PATH_INFO_ROOT_DIST)"
	@echo "~> make distTest                 - build dist at ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST} in local OS"
	@echo "~> make distTestTar              - build dist at ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST} in local OS and tar"
	@echo "~> make distTestOS               - build dist at ${ENV_PATH_INFO_ROOT_DIST_OS} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH)"
	@echo "~> make distTestOSTar            - build dist at ${ENV_PATH_INFO_ROOT_DIST_OS} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH) and tar"
	@echo "~> make distRelease              - build dist at ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE} in local OS"
	@echo "~> make distReleaseTar           - build dist at ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE} in local OS and tar"
	@echo "~> make distReleaseOS            - build dist at ${ENV_PATH_INFO_ROOT_DIST_OS} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH)"
	@echo "~> make distReleaseOSTar         - build dist at ${ENV_PATH_INFO_ROOT_DIST_OS} as: $(ENV_INFO_DIST_GO_OS) $(ENV_INFO_DIST_GO_ARCH) and tar"
	@echo "~> make distAllLocalTar          - build all local tar to dist"
	@echo "~> make distPlatformTarCommonUse - build tar to dist ${ENV_INFO_PLATFORM_OS_LINUX}-amd64 ${ENV_INFO_PLATFORM_OS_WINDOWS}-amd64 ${ENV_INFO_PLATFORM_OS_MACOS}-amd64 ${ENV_INFO_PLATFORM_OS_MACOS}-arm64"
	@echo "~> make distPlatformTarAll       - build all platform tar to dist and tar"
	@echo ""
