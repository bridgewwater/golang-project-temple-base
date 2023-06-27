# this file must use as base Makefile
# use as:
# include z-MakefileUtils/MakeBasicEnv.mk

# env PLATFORM OS_BIT ENV_ROOT ENV_HOME_PATH
ifeq ($(OS),Windows_NT)
  PLATFORM=Windows
#  OS_BIT?=${shell if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (echo x86_64) ELSE echo x86}
  OS_BIT?=$(shell echo `uname -m`) # x86_64 arm64
  # do windows powershell
  ENV_ROOT?=$(shell pwd)
  ENV_HOME_PATH?=${shell echo %UserProfile%}
  # ENV_NOW_TIME_FORMAT = $(shell echo %Date:~0,4%%Date:~5,2%%Date:~8,2%)
  ENV_NOW_TIME_FORMAT=$(shell echo %Date:~0,4%-%Date:~5,2%-%Date:~8,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%)
else
  OS_UNAME?=$(shell echo `uname`) # Linux Darwin
  OS_BIT?=$(shell echo `uname -m`) # x86_64 arm64
  ENV_ROOT?=$(shell pwd)
  ENV_HOME_PATH?=${HOME}
  # ENV_NOW_TIME_FORMAT = $(shell date -u '+%Y-%m-%d-%H-%M-%S')
  ENV_NOW_TIME_FORMAT = $(shell date '+%Y-%m-%d-%H-%M-%S')
  ifeq ($(shell uname),Darwin)
    PLATFORM=MacOS
    ifeq ($(shell echo ${OS_BIT}),arm64)
      PLATFORM=MacOS-Apple-Silicon
    else
      PLATFORM=MacOS-Intel
    endif
    # do MacOS

  else
    PLATFORM=Unix-Like
    # do unix
  endif
endif

# change by env
ifneq ($(strip $(ENV_CI_DIST_VERSION)),)
    ENV_DIST_VERSION=${ENV_CI_DIST_VERSION}
endif

# this can change to other mark https://docs.drone.io/pipeline/environment/substitution/
ifneq ($(strip $(DRONE_TAG)),)
$(info -> change ENV_DIST_MARK by DRONE_TAG)
    ENV_DIST_MARK=-tag.${DRONE_TAG}
else
    ifneq ($(strip $(DRONE_COMMIT)),)
$(info -> change ENV_DIST_MARK by DRONE_COMMIT)
        ENV_DIST_MARK=-${DRONE_COMMIT}
    endif
endif
ifneq ($(strip $(GITHUB_SHA)),)
$(info -> change ENV_DIST_MARK by GITHUB_SHA)
    ENV_DIST_MARK=-${GITHUB_SHA}# https://docs.github.com/cn/enterprise-server@2.22/actions/learn-github-actions/environment-variables
endif
ifeq ($(strip $(ENV_DIST_MARK)),)
$(info -> change ENV_DIST_MARK by git)
    ENV_DIST_MARK=-$(strip $(shell git --no-pager rev-parse --short HEAD))
endif
ifneq ($(strip $(ENV_CI_DIST_MARK)),)
$(info -> change ENV_DIST_MARK by ENV_CI_DIST_MARK)
    ENV_DIST_MARK=-${ENV_CI_DIST_MARK}
endif

envBasic:
	@echo ------- start show env basic---------
	@echo ""
	@echo "PLATFORM                                  ${PLATFORM}"
	@echo "OS_BIT                                    ${OS_BIT}"
	@echo "ROOT_NAME                                 ${ROOT_NAME}"
	@echo "ENV_ROOT                                  ${ENV_ROOT}"
	@echo "ENV_NOW_TIME_FORMAT                       ${ENV_NOW_TIME_FORMAT}"
	@echo "ENV_HOME_PATH                             ${ENV_HOME_PATH}"
	@echo ""
	@echo ------- end  show env basic ---------

envDistBasic:
	@echo "ENV_DIST_VERSION :                        ${ENV_DIST_VERSION}"
	@echo "ENV_DIST_MARK :                           ${ENV_DIST_MARK}"
	@echo ""