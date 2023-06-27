# this file must use as base Makefile
# use at Makefile
# include MakefileUtils/MakeDistTools.mk

ENV_PATH_INFO_ROOT_DIST=dist
ENV_PATH_INFO_ROOT_DIST_LOCAL=${ENV_PATH_INFO_ROOT_DIST}/local
ENV_PATH_INFO_ROOT_DIST_OS=${ENV_PATH_INFO_ROOT_DIST}/os
ENV_INFO_PLATFORM_OS_ARCH_AMD64=amd64
ENV_INFO_PLATFORM_OS_ARCH_386=386
ENV_INFO_PLATFORM_OS_ARCH_ARM64=arm64
ENV_INFO_PLATFORM_OS_ARCH_ARM=arm
ENV_INFO_PLATFORM_OS_ARCH_MIPS=mips
ENV_INFO_PLATFORM_OS_ARCH_MIPS64=mips64
ENV_INFO_PLATFORM_OS_ARCH_MIPS64LE=mips64le
ENV_INFO_PLATFORM_OS_ARCH_RISCV64=riscv64
ENV_INFO_PLATFORM_OS_ARCH_S390X=s390x
ENV_INFO_PLATFORM_OS_ARCH_PPC64=ppc64
ENV_INFO_PLATFORM_OS_ARCH_PPC64LE=ppc64le
ENV_INFO_PLATFORM_OS_ARCH_LOONG64=loong64

pathDistEnv:
	@echo "-----------------  this pathDistEnv has start -----------------"
ifeq ($(OS),Windows_NT)
	@echo "ENV_PATH_INFO_ROOT_DIST                                $(subst /,\,${ENV_PATH_INFO_ROOT_DIST})"
	@echo "ENV_PATH_INFO_ROOT_DIST_LOCAL                          $(subst /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL})"
	@echo "ENV_PATH_INFO_ROOT_DIST_OS                             $(subst /,\,${ENV_PATH_INFO_ROOT_DIST_OS})"
	@echo ""
	@echo "-----------------"
	@echo "ENV_INFO_PLATFORM_OS_WINDOWS                           $(subst /,\,${ENV_INFO_PLATFORM_OS_WINDOWS})"
	@echo ""
	@echo "pathCheckRootDistPlatformWinAmd64 cleanRootDistPlatformWinAmd64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64                $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64})"
	@echo ""
	@echo "pathCheckRootDistPlatformWin386 cleanRootDistPlatformWin386"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386                  $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386})"
	@echo ""
	@echo "pathCheckRootDistPlatformWinArm64 cleanRootDistPlatformWinArm64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64                $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64})"
	@echo ""
	@echo "pathCheckRootDistPlatformWinArm cleanRootDistPlatformWinArm"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM                  $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM})"
	@echo ""
	@echo "pathCheckRootDistPlatformWinAll     to check windows"
	@echo "-----------------"
	@echo ""
	@echo "-----------------"
	@echo "ENV_INFO_PLATFORM_OS_MACOS                             $(subst /,\,${ENV_INFO_PLATFORM_OS_MACOS})"
	@echo ""
	@echo "pathCheckRootDistPlatformMacOsAmd64 cleanRootDistPlatformMacOsAmd64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64                       $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64})"
	@echo ""
	@echo "pathCheckRootDistPlatformMacOsArm64 cleanRootDistPlatformMacOsArm64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64                       $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64})"
	@echo ""
	@echo "pathCheckRootDistPlatformMacOsAll   to check all macOS"
	@echo "-----------------"
	@echo ""
	@echo "-----------------"
	@echo "ENV_INFO_PLATFORM_OS_LINUX                             $(subst /,\,${ENV_INFO_PLATFORM_OS_LINUX})"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxAmd64 cleanRootDistPlatformLinuxAmd64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64                  $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64})"
	@echo ""
	@echo "pathCheckRootDistPlatformLinux386 cleanRootDistPlatformLinuxAmd386"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_386                    $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_LINUX_386})"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxArm64 cleanRootDistPlatformLinuxArm64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64                  $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64})"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxArm cleanRootDistPlatformLinuxArm"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM                    $(subst /,\,${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM})"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxCommon to check linux common use"
	@echo "-----------------"
	@echo ""
	@echo "pathCheckRootDistLocalTest cleanRootDistLocalTest"
	@echo "ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST                     $(subts /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST})"
	@echo ""
	@echo "pathCheckRootDistLocalRelease cleanRootDistLocalRelease"
	@echo "ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE                  $(subts /,\,${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE})"
	@echo ""
else
	@echo "ENV_PATH_INFO_ROOT_DIST                                ${ENV_PATH_INFO_ROOT_DIST}"
	@echo "ENV_PATH_INFO_ROOT_DIST_LOCAL                          ${ENV_PATH_INFO_ROOT_DIST_LOCAL}"
	@echo "ENV_PATH_INFO_ROOT_DIST_OS                             ${ENV_PATH_INFO_ROOT_DIST_OS}"
	@echo ""
	@echo "-----------------"
	@echo "ENV_INFO_PLATFORM_OS_WINDOWS                           ${ENV_INFO_PLATFORM_OS_WINDOWS}"
	@echo ""
	@echo "pathCheckRootDistPlatformWinAmd64 cleanRootDistPlatformWinAmd64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64                ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}"
	@echo ""
	@echo "pathCheckRootDistPlatformWin386 cleanRootDistPlatformWin386"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386                  ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}"
	@echo ""
	@echo "pathCheckRootDistPlatformWinArm64 cleanRootDistPlatformWinArm64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64                ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}"
	@echo ""
	@echo "pathCheckRootDistPlatformWinArm cleanRootDistPlatformWinArm"
	@echo "ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM                  ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}"
	@echo ""
	@echo "pathCheckRootDistPlatformWinAll     to check windows"
	@echo "-----------------"
	@echo ""
	@echo "-----------------"
	@echo "ENV_INFO_PLATFORM_OS_MACOS                             ${ENV_INFO_PLATFORM_OS_MACOS}"
	@echo ""
	@echo "pathCheckRootDistPlatformMacOsAmd64 cleanRootDistPlatformMacOsAmd64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64                       ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}"
	@echo ""
	@echo "pathCheckRootDistPlatformMacOsArm64 cleanRootDistPlatformMacOsArm64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64                       ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}"
	@echo ""
	@echo "pathCheckRootDistPlatformMacOsAll   to check all macOS"
	@echo ""
	@echo "-----------------"
	@echo ""
	@echo "-----------------"
	@echo "ENV_INFO_PLATFORM_OS_LINUX                             ${ENV_INFO_PLATFORM_OS_LINUX}"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxAmd64 cleanRootDistPlatformLinuxAmd64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64                  ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}"
	@echo ""
	@echo "pathCheckRootDistPlatformLinux386 cleanRootDistPlatformLinuxAmd386"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_386                    ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxArm64 cleanRootDistPlatformLinuxArm64"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64                  ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxArm cleanRootDistPlatformLinuxArm"
	@echo "ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM                    ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}"
	@echo ""
	@echo "pathCheckRootDistPlatformLinuxCommon to check linux common use"
	@echo "-----------------"
	@echo ""
	@echo "pathCheckRootDistLocalTest cleanRootDistLocalTest"
	@echo "ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST                     ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}"
	@echo ""
	@echo "pathCheckRootDistLocalRelease cleanRootDistLocalRelease"
	@echo "ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE                  ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}"
	@echo ""
endif

	@echo ""
	@echo "ENV_INFO_PLATFORM_OS_ARCH_AMD64                        ${ENV_INFO_PLATFORM_OS_ARCH_AMD64}"
	@echo "ENV_INFO_PLATFORM_OS_ARCH_386                          ${ENV_INFO_PLATFORM_OS_ARCH_386}"
	@echo "ENV_INFO_PLATFORM_OS_ARCH_ARM64                        ${ENV_INFO_PLATFORM_OS_ARCH_ARM64}"
	@echo "ENV_INFO_PLATFORM_OS_ARCH_ARM                          ${ENV_INFO_PLATFORM_OS_ARCH_ARM}"
	@echo "-----------------  this pathDistEnv has end -----------------"

cleanDistAll:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST}
else
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST}
endif
	$(info -> has clean ${ENV_PATH_INFO_ROOT_DIST})

pathCheckRootDist: | $(ENV_PATH_INFO_ROOT_DIST)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_INFO_ROOT_DIST}"

$(ENV_PATH_INFO_ROOT_DIST):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_INFO_ROOT_DIST}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST}
else
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST}
endif

cleanRootDistLocal:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_LOCAL}
else
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_LOCAL}
endif
	$(info -> has clean ${ENV_PATH_INFO_ROOT_DIST_LOCAL})

pathCheckRootDistLocal: | $(ENV_PATH_INFO_ROOT_DIST_LOCAL)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_INFO_ROOT_DIST_LOCAL}"

$(ENV_PATH_INFO_ROOT_DIST_LOCAL):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_INFO_ROOT_DIST_LOCAL}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_LOCAL}
else
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_LOCAL}
endif

ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST=${ENV_PATH_INFO_ROOT_DIST_LOCAL}/test

pathCheckRootDistLocalTest: | $(ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}"

$(ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}
else
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}
endif

cleanRootDistLocalTest:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}
else
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST}
endif
	$(info -> has clean ${ENV_PATH_INFO_ROOT_DIST_LOCAL_TEST})

ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE=${ENV_PATH_INFO_ROOT_DIST_LOCAL}/release

pathCheckRootDistLocalRelease: | $(ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}"

$(ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}
else
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}
endif

cleanRootDistLocalRelease:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}
else
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE}
endif
	$(info -> has clean ${ENV_PATH_INFO_ROOT_DIST_LOCAL_RELEASE})

cleanRootDistOs:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_OS}
else
	@$(RM) -r ${ENV_PATH_INFO_ROOT_DIST_OS}
endif
	$(info -> has clean ${ENV_PATH_INFO_ROOT_DIST_OS})

pathCheckRootDistOs: | $(ENV_PATH_INFO_ROOT_DIST_OS)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_INFO_ROOT_DIST_OS}"

$(ENV_PATH_INFO_ROOT_DIST_OS):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_INFO_ROOT_DIST_OS}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_OS}
else
	@mkdir -p ${ENV_PATH_INFO_ROOT_DIST_OS}
endif

ENV_INFO_PLATFORM_OS_WINDOWS=windows

ENV_PATH_DIST_PLATFORM_OS_WINDOWS=${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_WINDOWS}

pathCheckRootDistPlatformWin: | $(ENV_PATH_DIST_PLATFORM_OS_WINDOWS)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}"

$(ENV_PATH_DIST_PLATFORM_OS_WINDOWS):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}
endif

cleanRootDistPlatformWin:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS})

ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64=${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}

pathCheckRootDistPlatformWinAmd64: | $(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}"

$(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}
endif

cleanRootDistPlatformWinAmd64:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_AMD64})

ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386=${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_386}

pathCheckRootDistPlatformWin386: | $(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}"

$(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}
endif

cleanRootDistPlatformWin386:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_386})

ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64=${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}

pathCheckRootDistPlatformWinArm64: | $(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}"

$(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}
endif

cleanRootDistPlatformWinArm64:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM64})

ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM=${ENV_PATH_DIST_PLATFORM_OS_WINDOWS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM}

pathCheckRootDistPlatformWinArm: | $(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}"

$(ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}
endif

cleanRootDistPlatformWinArm:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_WINDOWS_ARM})

pathCheckRootDistPlatformWinAll: pathCheckRootDistPlatformWinAmd64 pathCheckRootDistPlatformWin386 pathCheckRootDistPlatformWinArm64 pathCheckRootDistPlatformWinArm

ENV_INFO_PLATFORM_OS_MACOS=darwin
ENV_PATH_DIST_PLATFORM_OS_MACOS=${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_MACOS}

pathCheckRootDistPlatformMacOs: | $(ENV_PATH_DIST_PLATFORM_OS_MACOS)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_MACOS}"

$(ENV_PATH_DIST_PLATFORM_OS_MACOS):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_MACOS}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_MACOS}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_MACOS}
endif

cleanRootDistPlatformMacOs:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_MACOS}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_MACOS}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_MACOS})

ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64=${ENV_PATH_DIST_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}

pathCheckRootDistPlatformMacOsAmd64: | $(ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}"

$(ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}
endif

cleanRootDistPlatformMacOsAmd64:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_MACOS_AMD64})

ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64=${ENV_PATH_DIST_PLATFORM_OS_MACOS}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}

pathCheckRootDistPlatformMacOsArm64: | $(ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}"

$(ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}
endif

cleanRootDistPlatformMacOsArm64:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_MACOS_ARM64})

pathCheckRootDistPlatformMacOsAll: pathCheckRootDistPlatformMacOsArm64 pathCheckRootDistPlatformMacOsAmd64

ENV_INFO_PLATFORM_OS_LINUX=linux

ENV_PATH_DIST_PLATFORM_OS_LINUX=${ENV_PATH_INFO_ROOT_DIST_OS}/${ENV_INFO_PLATFORM_OS_LINUX}

pathCheckRootDistPlatformLinux: | $(ENV_PATH_DIST_PLATFORM_OS_LINUX)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX}"

$(ENV_PATH_DIST_PLATFORM_OS_LINUX):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX}
endif

cleanRootRootDistPlatformLinux:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_LINUX})

ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64=${ENV_PATH_DIST_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_AMD64}

pathCheckRootDistPlatformLinuxAmd64: | $(ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}"

$(ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}
endif

cleanRootDistPlatformLinuxAmd64:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_LINUX_AMD64})

ENV_PATH_DIST_PLATFORM_OS_LINUX_386=${ENV_PATH_DIST_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_386}

pathCheckRootDistPlatformLinux386: | $(ENV_PATH_DIST_PLATFORM_OS_LINUX_386)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}"

$(ENV_PATH_DIST_PLATFORM_OS_LINUX_386):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}
endif

cleanRootDistPlatformLinuxAmd386:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_LINUX_386})

ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64=${ENV_PATH_DIST_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM64}

pathCheckRootDistPlatformLinuxArm64: | $(ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}"

$(ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}
endif

cleanRootDistPlatformLinuxArm64:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM64})

ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM=${ENV_PATH_DIST_PLATFORM_OS_LINUX}/${ENV_INFO_PLATFORM_OS_ARCH_ARM}

pathCheckRootDistPlatformLinuxArm: | $(ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM)
	@echo "-> dist folder tools path exist at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}"

$(ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM):
	@echo "-> dist folder tools does not exist, try mkdir at: ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}"
ifeq ($(OS),Windows_NT)
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}
else
	@mkdir -p ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}
endif

cleanRootDistPlatformLinuxArm:
ifeq ($(OS),Windows_NT)
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}
else
	@$(RM) -r ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM}
endif
	$(info -> has clean ${ENV_PATH_DIST_PLATFORM_OS_LINUX_ARM})

pathCheckRootDistPlatformLinuxCommon: pathCheckRootDistPlatformLinuxAmd64 pathCheckRootDistPlatformLinux386 pathCheckRootDistPlatformLinuxArm64 pathCheckRootDistPlatformLinuxArm
