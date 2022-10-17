# this file must use as base Makefile job must has [ dep buildMain buildARCH ]

SERVER_TEST_SSH_ALIASE = aliyun-ecs
SERVER_TEST_FOLDER = /home/work/Document/
SERVER_REPO_SSH_ALIASE = golang-project-temple-base
SERVER_REPO_FOLDER = /home/ubuntu/$(ROOT_NAME)

checkTestDistPath:
	@if [ ! -d ${ROOT_TEST_DIST_PATH} ]; \
	then mkdir -p ${ROOT_TEST_DIST_PATH} && echo "~> mkdir ${ROOT_TEST_DIST_PATH}"; \
	fi

checkTestOSDistPath:
	@if [ ! -d ${ROOT_TEST_OS_DIST_PATH} ]; \
	then mkdir -p ${ROOT_TEST_OS_DIST_PATH} && echo "~> mkdir ${ROOT_TEST_OS_DIST_PATH}"; \
	fi

checkReleaseDistPath:
	@if [ ! -d ${ROOT_REPO_DIST_PATH} ]; \
	then mkdir -p ${ROOT_REPO_DIST_PATH} && echo "~> mkdir ${ROOT_REPO_DIST_PATH}"; \
	fi

checkReleaseOSDistPath:
	@if [ ! -d ${ROOT_REPO_OS_DIST_PATH} ]; \
	then mkdir -p ${ROOT_REPO_OS_DIST_PATH} && echo "~> mkdir ${ROOT_REPO_OS_DIST_PATH}"; \
	fi

cleanAllDist:
	@if [ -d ${ROOT_DIST} ]; \
	then rm -rf ${ROOT_DIST} && echo "~> cleaned ${ROOT_DIST}"; \
	else echo "~> has cleaned ${ROOT_DIST}"; \
	fi

distTest: dep buildMain checkTestDistPath
	@echo "=> distTest start at: $(ROOT_TEST_DIST_PATH)"
	cp $(ROOT_BUILD_BIN_PATH) $(ROOT_TEST_DIST_PATH)
	mv $(ROOT_TEST_DIST_PATH)/$(ROOT_BUILD_BIN_NAME) $(ROOT_TEST_DIST_PATH)/$(ROOT_DIS_BIN_NAME)
	@echo "=> distTest end at: $(ROOT_TEST_DIST_PATH)"

distTestTar: distTest
	@echo "=> start tar test as os local"
	tar zcvf $(ROOT_DIST)/test/$(ROOT_NAME)-test-$(ENV_DIST_VERSION).tar.gz -C $(ROOT_TEST_DIST_PATH) .

distTestOS: dep buildARCH checkTestOSDistPath
	@echo "=> distTestOS start at: $(ROOT_TEST_OS_DIST_PATH)"
	@echo "=> Test at: $(ENV_DIST_OS) ARCH as: $(ENV_DIST_ARCH)"
	cp $(ROOT_BUILD_BIN_PATH) $(ROOT_TEST_OS_DIST_PATH)
	mv $(ROOT_TEST_OS_DIST_PATH)/$(ROOT_BUILD_BIN_NAME) $(ROOT_TEST_OS_DIST_PATH)/$(ROOT_DIS_BIN_NAME)
	@echo "=> distTestOS end at: $(ROOT_TEST_OS_DIST_PATH)"

distTestOSTar: distTestOS
	@echo "=> start tar test as os local"
	tar zcvf $(ROOT_DIST)/$(ENV_DIST_OS)/test/$(ROOT_NAME)-$(ENV_DIST_OS)-$(ENV_DIST_ARCH)-$(ENV_DIST_VERSION).tar.gz -C $(ROOT_TEST_OS_DIST_PATH) .

distRelease: dep buildMain checkReleaseDistPath
	@echo "=> distRelease start at: $(ROOT_REPO_DIST_PATH)"
	cp $(ROOT_BUILD_BIN_PATH) $(ROOT_REPO_DIST_PATH)
	mv $(ROOT_REPO_DIST_PATH)/$(ROOT_BUILD_BIN_NAME) $(ROOT_REPO_DIST_PATH)/$(ROOT_DIS_BIN_NAME)
	@echo "=> distRelease end at: $(ROOT_REPO_DIST_PATH)"

distReleaseTar: distRelease
	@echo "=> start tar test as os local"
	tar zcvf $(ROOT_DIST)/$(ROOT_NAME)-release-$(ENV_DIST_VERSION).tar.gz -C $(ROOT_REPO_DIST_PATH) .

distReleaseOS: dep buildARCH checkReleaseOSDistPath
	@echo "=> distReleaseOS start at: $(ROOT_REPO_OS_DIST_PATH)"
	@echo "=> Release at: $(ENV_DIST_OS) ARCH as: $(ENV_DIST_ARCH)"
	cp $(ROOT_BUILD_BIN_PATH) $(ROOT_REPO_OS_DIST_PATH)
	mv $(ROOT_REPO_OS_DIST_PATH)/$(ROOT_BUILD_BIN_NAME) $(ROOT_REPO_OS_DIST_PATH)/$(ROOT_DIS_BIN_NAME)
	@echo "=> distReleaseOS end at: $(ROOT_REPO_OS_DIST_PATH)"

distReleaseOSTar: distReleaseOS
	@echo "=> start tar release as os $(ENV_DIST_OS) $(ENV_DIST_ARCH)"
	tar zcvf $(ROOT_DIST)/$(ENV_DIST_OS)/release/$(ROOT_NAME)-$(ENV_DIST_OS)-$(ENV_DIST_ARCH)-$(ENV_DIST_VERSION).tar.gz -C $(ROOT_REPO_OS_DIST_PATH) .

scpDistReleaseOSTar: distReleaseOSTar
	scp $(ROOT_DIST)/$(ENV_DIST_OS)/release/$(ROOT_NAME)-$(ENV_DIST_OS)-$(ENV_DIST_ARCH)-$(ENV_DIST_VERSION).tar.gz -C $(SERVER_REPO_SSH_ALIASE):$(SERVER_REPO_FOLDER) .
	@echo "=> must check below config of set for relase OS Scp"

helpDist:
	@echo "Help: helpDist.mk"
	@echo "-- distTestOS or distReleaseOS will out abi as: $(ENV_DIST_OS) $(ENV_DIST_ARCH) --"
	@echo "~> make cleanAllDist     - clean all dist at $(ROOT_DIST)"
	@echo "~> make distTest         - build dist at $(ROOT_TEST_DIST_PATH) in local OS"
	@echo "~> make distTestTar      - build dist at $(ROOT_TEST_DIST_PATH) in local OS and tar"
	@echo "~> make distTestOS       - build dist at $(ROOT_TEST_OS_DIST_PATH) as: $(ENV_DIST_OS) $(ENV_DIST_ARCH)"
	@echo "~> make distTestOSTar    - build dist at $(ROOT_TEST_OS_DIST_PATH) as: $(ENV_DIST_OS) $(ENV_DIST_ARCH) and tar"
	@echo "~> make distRelease      - build dist at $(ROOT_REPO_DIST_PATH) in local OS"
	@echo "~> make distReleaseOS    - build dist at $(ROOT_REPO_OS_DIST_PATH) as: $(ENV_DIST_OS) $(ENV_DIST_ARCH)"
	@echo "~> make distReleaseOSTar - build dist at $(ROOT_REPO_OS_DIST_PATH) as: $(ENV_DIST_OS) $(ENV_DIST_ARCH) and tar"
	@echo ""