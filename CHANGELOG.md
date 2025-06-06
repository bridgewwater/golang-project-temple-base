# Changelog

All notable changes to this project will be documented in this file. See [convention-change-log](https://github.com/convention-change/convention-change-log) for commit guidelines.

## [2.2.0](https://github.com/bridgewwater/golang-project-temple-base/compare/v2.1.0...v2.2.0) (2025-06-02)

### ✨ Features

* use github.com/sinlov-go/unittest-kit ([443d78ca](https://github.com/bridgewwater/golang-project-temple-base/commit/443d78cad198cc5e7cc8cf4fe1b4f9b84980bc16))

* update test case and make ci* for fast task run ([08e22c45](https://github.com/bridgewwater/golang-project-temple-base/commit/08e22c4562219f8d4f659e29d4e2432bcd442ec4))

### ♻ Refactor

* rename pkg name and file name ([af0eb580](https://github.com/bridgewwater/golang-project-temple-base/commit/af0eb580898f4ff467fd1d3b648669141d809300))

### 👷‍ Build System

* improve CI/CD workflows and code quality ([221f359f](https://github.com/bridgewwater/golang-project-temple-base/commit/221f359ffd5a0a7ae843bf2bca3d3d566a3c4fea))

* bump github.com/stretchr/testify from 1.9.0 to 1.10.0 ([d7e9ab2a](https://github.com/bridgewwater/golang-project-temple-base/commit/d7e9ab2af4854bc7a981a28aa2108e294444a954))

* bump github.com/sinlov-go/unittest-kit from 1.1.1 to 1.2.1 ([ae68d256](https://github.com/bridgewwater/golang-project-temple-base/commit/ae68d2565e458a066cfc8733588ebba224f9e219))

* bump github.com/sinlov-go/unittest-kit from 1.1.0 to 1.1.1 ([c43b20fe](https://github.com/bridgewwater/golang-project-temple-base/commit/c43b20fe54004b788c2ffd07978b4964e856b8e0))

* bump github.com/sebdah/goldie/v2 from 2.5.3 to 2.5.5 ([7f26c1f2](https://github.com/bridgewwater/golang-project-temple-base/commit/7f26c1f23150d24ed08e44e8101495a187ecf128))

* support inject `buildID` at CI pipline ([c3ef6436](https://github.com/bridgewwater/golang-project-temple-base/commit/c3ef643638a152d5b9c60ee7329e9c4d00fb1896))

* bump golangci/golangci-lint-action from 5 to 6 ([00ecdb73](https://github.com/bridgewwater/golang-project-temple-base/commit/00ecdb73317a9ee97ebd220a10a99c564bd3e45e))

* bump convention-change/conventional-version-check ([46aecae8](https://github.com/bridgewwater/golang-project-temple-base/commit/46aecae8bb07a07aea493199dd6803feca3f5ce3))

* bump golangci/golangci-lint-action from 4 to 5 ([9de0b661](https://github.com/bridgewwater/golang-project-temple-base/commit/9de0b661e014cbb1cfbff16bde938cfd3b70b3f5))

* bump github.com/stretchr/testify from 1.8.4 to 1.9.0 ([301da77c](https://github.com/bridgewwater/golang-project-temple-base/commit/301da77ce9a088d62b4ab6d1424c281cbb50d92d))

* bump github.com/sinlov-go/unittest-kit from 1.0.0 to 1.1.0 ([17f55d1d](https://github.com/bridgewwater/golang-project-temple-base/commit/17f55d1d6481216787399487046738158ed15729))

* bump github.com/stretchr/testify from 1.8.4 to 1.9.0 ([b5db8740](https://github.com/bridgewwater/golang-project-temple-base/commit/b5db87406c3599e0900caf5bb65000033b5fba0d))

* bump actions/upload-artifact from 3 to 4 ([2de7acbc](https://github.com/bridgewwater/golang-project-temple-base/commit/2de7acbc4b61594cc28c13e8c8650e0a6d05f59a))

* bump actions/setup-go from 4 to 5 ([dc8404db](https://github.com/bridgewwater/golang-project-temple-base/commit/dc8404db010da50c555b805704c81bb263a70500))

* bump actions/download-artifact from 3 to 4 ([b2a99836](https://github.com/bridgewwater/golang-project-temple-base/commit/b2a99836c58a3828734dda3917dd51ede70d5ff3))

* update go version to 1.19.12 for build ([99d5a3c5](https://github.com/bridgewwater/golang-project-temple-base/commit/99d5a3c568e3573b9297aa170e143df9f749bb18))

* fix name of go-release-platform.yml ([4f58c9c1](https://github.com/bridgewwater/golang-project-temple-base/commit/4f58c9c1a6e399be602a03edef0a6839f4e860b3))

## [2.1.0](https://github.com/bridgewwater/golang-project-temple-base/compare/2.0.0...v2.1.0) (2023-12-19)

### 🐛 Bug Fixes

* fix shell tools parse not help ([a6acc37b](https://github.com/bridgewwater/golang-project-temple-base/commit/a6acc37bad4a127f659813299e57c2db310ff0a9))

* add full go style check ([f616211d](https://github.com/bridgewwater/golang-project-temple-base/commit/f616211da5393a088897a1d7e8db0a2224bcad17))

### ✨ Features

* updatee template for build info ([e6c4cc4a](https://github.com/bridgewwater/golang-project-temple-base/commit/e6c4cc4abcfaf1a2dd6301f6c5368775b3692280))

* change cmd to folder package at cmd/[bin name] ([d0d67fc4](https://github.com/bridgewwater/golang-project-temple-base/commit/d0d67fc41b03da258e016971dbb457cb3db2dad5))

* add z-MakefileUtils/MakeGoTest.mk for make task manamgent ([5dc9c7d5](https://github.com/bridgewwater/golang-project-temple-base/commit/5dc9c7d5b2cd9c16e50e79cf1dce699c6592e989))

* update drone ([4c357010](https://github.com/bridgewwater/golang-project-temple-base/commit/4c3570103fff0a16209759f89ad72a62cca07c7a))

* can change by env:ENV_CI_DIST_VERSION use and change by env:ENV_CI_DIST_MARK by CI ([e77928ca](https://github.com/bridgewwater/golang-project-temple-base/commit/e77928ca56576da3b59317e0cb462c202257cbe1))

* update makeGoDist ([81429328](https://github.com/bridgewwater/golang-project-temple-base/commit/814293285fe0f87e223c594274d1092dd5f596ff))

* fix dist windows file error ([bcef3163](https://github.com/bridgewwater/golang-project-temple-base/commit/bcef3163321bf229c41f7ef9f1611b8505155fd0))

* update drone.yml ([ad89634e](https://github.com/bridgewwater/golang-project-temple-base/commit/ad89634e20701da5666350a8348771ad1643e708))

* add dist info show ([8e1b628d](https://github.com/bridgewwater/golang-project-temple-base/commit/8e1b628d8679af3ba8787627ff98a7ac2e40244e))

* update drone template ([df788ec4](https://github.com/bridgewwater/golang-project-temple-base/commit/df788ec4605e7bd7091ab24736f7061dc6838b8b))

* update MakeDocker.mk ([25775b9f](https://github.com/bridgewwater/golang-project-temple-base/commit/25775b9f3d730b42c4a8359bed7e8e928f099fc0))

* update help document ([e81f8c56](https://github.com/bridgewwater/golang-project-temple-base/commit/e81f8c566a8d66e7a68ff7878641c29df88edd20))

* remove .github/go-release.md for template ([e33937e9](https://github.com/bridgewwater/golang-project-temple-base/commit/e33937e9b8337a16a8145f28ca7180834aca35a2))

### 👷‍ Build System

* bump actions/checkout from 3 to 4 ([5fa16a21](https://github.com/bridgewwater/golang-project-temple-base/commit/5fa16a21708914e100d183ef40a85d15126cab96))

* update temp-golang-base and remove modVendor at task of make dep ([1bd6686a](https://github.com/bridgewwater/golang-project-temple-base/commit/1bd6686a143a35435235fc9980ed7b172d4545d0))

* change workflow to ci.yml ([7749ef6b](https://github.com/bridgewwater/golang-project-temple-base/commit/7749ef6b4d0d507a274fca39cd853ce40d17a8ae))

* change to go verison 1.18.10 ([fe0c6722](https://github.com/bridgewwater/golang-project-temple-base/commit/fe0c6722176a8337396f3c280ae8741702956ffa))

* update temp-golang-base ([962a2031](https://github.com/bridgewwater/golang-project-temple-base/commit/962a2031c4f1f584c5a6a644346aafbea12d9314))

* change make to support windows busybox ([94265584](https://github.com/bridgewwater/golang-project-temple-base/commit/94265584a3366dc397b24ac9b2687b598c1d6a50))

* update markfile default style ([9e43f63b](https://github.com/bridgewwater/golang-project-temple-base/commit/9e43f63b57e70756593db08669523fa59cf160d3))

* update base path ([36a24b99](https://github.com/bridgewwater/golang-project-temple-base/commit/36a24b9956dc4b7e38b4ffcf2e3d94963e0a3c66))

* update drone and Makfile for build ([4ab0c68e](https://github.com/bridgewwater/golang-project-temple-base/commit/4ab0c68e7a8e78d578dcfe2fee413c2f78d6372d))

* changet to github.com/stretchr/testify v1.8.4 ([ade76a8d](https://github.com/bridgewwater/golang-project-temple-base/commit/ade76a8de9bd3cec44490b0c5002452f94b894fd))

* update make task clean ([83080ff6](https://github.com/bridgewwater/golang-project-temple-base/commit/83080ff66d126ad6eb60898eb0a17496a98194af))

* change clean build task ([b60027e8](https://github.com/bridgewwater/golang-project-temple-base/commit/b60027e89d7a376b285a72cdef09bafd5bb6b175))

## [2.0.0](https://github.com/bridgewwater/golang-project-temple-base/compare/v1.17.13...v2.0.0) (2023-02-08)

### Features

* add .gitattributes ([d4d2082](https://github.com/bridgewwater/golang-project-temple-base/commit/d4d20828cb3e7b87965ff9d30bb1b947b2d64985))

* add diffetent platform support of windows building as tar file ([6dc4841](https://github.com/bridgewwater/golang-project-temple-base/commit/6dc4841e06e86658efd2586e5bc3a73d968c651c))

* add dist_tar_with_windows_source for windows support ([d21f4d0](https://github.com/bridgewwater/golang-project-temple-base/commit/d21f4d0561178847e97672c116f4600d64b222fd))

* add distPlatformTarCommonUse at MakeGoDist.mk ([e47ef6d](https://github.com/bridgewwater/golang-project-temple-base/commit/e47ef6dc7122ba98dc4464357dc2adeadbd18627))

* add distTestTar task ([41f1264](https://github.com/bridgewwater/golang-project-temple-base/commit/41f1264e0362a4ca44017fae053ac242ffe50e6e))

* add ENV_CI_DIST_VERSION to change ENV_DIST_VERSION ([3648604](https://github.com/bridgewwater/golang-project-temple-base/commit/364860403d149c72ff0fe6566e70babec593f30f))

* add ENV_DIST_MARK can change by git ([a32e546](https://github.com/bridgewwater/golang-project-temple-base/commit/a32e546c4a5c631814a26d2bc1a42ea502d993d3))

* add github action template ([fca7c13](https://github.com/bridgewwater/golang-project-temple-base/commit/fca7c13002e0c6b2e4748b9919638b23a7caa1f3))

* add go_static_binary_windows_dist to try build at windows ([0e715f9](https://github.com/bridgewwater/golang-project-temple-base/commit/0e715f941b3d3cd0058a82290579da174e46f699))

* add more clear make script ([18440b4](https://github.com/bridgewwater/golang-project-temple-base/commit/18440b4a202c146d2aa43c34fa7f4360589ddb2e))

* add more info winodws show distTestOS ([14de258](https://github.com/bridgewwater/golang-project-temple-base/commit/14de25878824454d933c131365e45e1948adaea2))

* add packageJson.go use embed load package.json ([390b41e](https://github.com/bridgewwater/golang-project-temple-base/commit/390b41edcd09b361ca5e2cdbabfc529460a602dd))

* add sha256 check at dist tar ([7a521db](https://github.com/bridgewwater/golang-project-temple-base/commit/7a521db1bfafcaa03d1353779c1c457935728ccb))

* add warning distTestOS ([01542a1](https://github.com/bridgewwater/golang-project-temple-base/commit/01542a1d31dbfb1187c973429180d79af2768013))

* change main version use const ([c7ccaea](https://github.com/bridgewwater/golang-project-temple-base/commit/c7ccaea61adbf56d7ff38aa9b74318131198fe84))

* change to z-MakefileUtils to reduce the impact on the project directory ([fd265a4](https://github.com/bridgewwater/golang-project-temple-base/commit/fd265a4ff6b67dc8f36f8fcc739eaf58fd140b1a))

* format env as show ([d732b65](https://github.com/bridgewwater/golang-project-temple-base/commit/d732b655b00dbb910e6dbcccdcab00e5bd1da34a))

* let all var as ENV_ prefix ([7865a79](https://github.com/bridgewwater/golang-project-temple-base/commit/7865a799df273109ebc50b7d933f9f2f23629d2e))

* let dist os support os info to show ([f515ab6](https://github.com/bridgewwater/golang-project-temple-base/commit/f515ab605ffd4012b984207847701486ef1e1808))

* let distRelease be ok ([c278013](https://github.com/bridgewwater/golang-project-temple-base/commit/c27801380c015e2c22e0b0d12a87d2f807cf8986))

* let distScpTestOSTar support windows ([08ab8c0](https://github.com/bridgewwater/golang-project-temple-base/commit/08ab8c09e5a750e86d25d05ed12b5de62fa22279))

* let env show as windows ([d442140](https://github.com/bridgewwater/golang-project-temple-base/commit/d442140497c55999c86b5747c29ba40d8357bf3f))

* let go_static_binary_windows_dist can use ([1b53a22](https://github.com/bridgewwater/golang-project-temple-base/commit/1b53a221d515a739d37ce24e14e36ae26e96a379))

* let warning -> change ENV_DIST_MARK by git ([12dae79](https://github.com/bridgewwater/golang-project-temple-base/commit/12dae796586e05adb8665a2c69669cc74316ce03))

* makefile support windows path ([9c3e71f](https://github.com/bridgewwater/golang-project-temple-base/commit/9c3e71fe5f8a26bbb1172aa6c08d59dcc795c49a))

* remove # proxy golang setting at Dockerfile ([62d45a6](https://github.com/bridgewwater/golang-project-temple-base/commit/62d45a6ab8be04da55fec91921d0806afbd006e1))

* support windows use docker build ([fe3162d](https://github.com/bridgewwater/golang-project-temple-base/commit/fe3162dcdfbf72d08c359e2ebf8ac2447c34f015))

* try to change testCoverage at windows ([8dc8a04](https://github.com/bridgewwater/golang-project-temple-base/commit/8dc8a0487029e1bb3f21b04987c70eda427f7991))

* update .drone.yml ([e289ccc](https://github.com/bridgewwater/golang-project-temple-base/commit/e289ccc8b361834ecd0579f10fc1bd1b122472dc))

* update actionTestBenchmark task ([5b015ac](https://github.com/bridgewwater/golang-project-temple-base/commit/5b015acbe60330e10404a09e3ed5919c686cd63e))

* update build as docker in drone ([7c8f666](https://github.com/bridgewwater/golang-project-temple-base/commit/7c8f666c8fbc8d3fc3c4e93c2e57968527d0035f))

* update codecov/codecov-action@v3.1.1 ([963c801](https://github.com/bridgewwater/golang-project-temple-base/commit/963c8016e1293c5ba0e9d6be021fb760836e1c84))

* update config at codecov ([8ad0e1e](https://github.com/bridgewwater/golang-project-temple-base/commit/8ad0e1ee7af3565e45615b416da758f8cd970a33))

* update ENV_DIST_MARK can change by tag ([b86a50e](https://github.com/bridgewwater/golang-project-temple-base/commit/b86a50e4e88b80afc6b45234d4bb7f14c7df681b))

* update github action golang build version error ([f57ee3f](https://github.com/bridgewwater/golang-project-temple-base/commit/f57ee3f5f2fa21b3f167fb22bbd90f6ee727657a))

* update make dev and run args ([5c834fc](https://github.com/bridgewwater/golang-project-temple-base/commit/5c834fcf913719f2ecf167389188e96d66f84a55))

* update make dist_tar_with_source support windows ([de5576e](https://github.com/bridgewwater/golang-project-temple-base/commit/de5576ead522c6f81108ad1f50558d7bb6452f74))

* update make distTest ([97a65ab](https://github.com/bridgewwater/golang-project-temple-base/commit/97a65ab52009e8f92ca7032de567102428e24693))

* update make env show test info ([28228fe](https://github.com/bridgewwater/golang-project-temple-base/commit/28228fe3d4be12665f1eb4b7b128a98ed34d21ae))

* update make testBenchmark ([f908f0a](https://github.com/bridgewwater/golang-project-temple-base/commit/f908f0a544c44b1fae60ba1e574aab6af2cce515))

* update makefile dev task ([e15af68](https://github.com/bridgewwater/golang-project-temple-base/commit/e15af6808fd64033600021b452a7262cb0dd2c70))

* update makefile for show env ([396016b](https://github.com/bridgewwater/golang-project-temple-base/commit/396016bf0132ab1f2b7d76ce59759b1bc21f5b5d))

* update makefile template ([ac4bbb9](https://github.com/bridgewwater/golang-project-temple-base/commit/ac4bbb98109259234ae96c3881c61a55331dab75))

* update Makefile test at Windows_NT ([c0a3554](https://github.com/bridgewwater/golang-project-temple-base/commit/c0a3554d8120e44adfb946a8d79f810de74be043))

* update Makefile to support windows makefile ([7dd4dd3](https://github.com/bridgewwater/golang-project-temple-base/commit/7dd4dd3b0948304bcff9a0560b1cc6bbdb424d28))

* update MakeGoAction ([150db67](https://github.com/bridgewwater/golang-project-temple-base/commit/150db6719acce704b3cfb35788d2690a7ecd2ccd))

* update MakeGoAction.mk ([b0d01b4](https://github.com/bridgewwater/golang-project-temple-base/commit/b0d01b4c05603e2ad1eb97f538ebec30152baf8d))

* update MakeGoDist to add distPlatformTarAll and fix MakeDocker run error ([d3d9be9](https://github.com/bridgewwater/golang-project-temple-base/commit/d3d9be944cb95b030168de66c76547da4ffd4ac6))

* update MakeGoDist.mk distAllTar ([992c262](https://github.com/bridgewwater/golang-project-temple-base/commit/992c262ba702642a81dc3538db3144c5f96234e6))

* update MakeGoMod.mk ([16b3678](https://github.com/bridgewwater/golang-project-temple-base/commit/16b36785ca76518b9f61fca4bbb27bb4d7b15378))

* update temp-golang-base ([f2e6501](https://github.com/bridgewwater/golang-project-temple-base/commit/f2e6501369ad417ad27f95e858ad51121573a441))

* update temp-golang-base for build ([b471830](https://github.com/bridgewwater/golang-project-temple-base/commit/b471830944107e0d66c7afa66847a9564e1e7437))

* update test case of function main() ([a76816b](https://github.com/bridgewwater/golang-project-temple-base/commit/a76816b9f2d2c4bc451119c63de01d6eca8816cd))

* update testCoverage task ([dd7c6ba](https://github.com/bridgewwater/golang-project-temple-base/commit/dd7c6ba6fd29b7977cc4bf6b0107d3696f7dfa9f))

* version 2.0.0 change build pipline support windows ([0f97753](https://github.com/bridgewwater/golang-project-temple-base/commit/0f977533d15fc713b6b4ddd1eed629cad54103c8))

### Bug Fixes

* fix build info not support windows ([6b8141e](https://github.com/bridgewwater/golang-project-temple-base/commit/6b8141e47c641394b3fe48b8002837587c77e796))

* fix tar commond error ([0daf347](https://github.com/bridgewwater/golang-project-temple-base/commit/0daf347dd7b87409f42d65dc0df0b9c0af2d65e2))

* fix temp-golang-base not support new makefile for build ([226abd6](https://github.com/bridgewwater/golang-project-temple-base/commit/226abd6c241b4d7545ae876e16717abd5619c180))

* fix windows can not use tar and shasum error ([46c0968](https://github.com/bridgewwater/golang-project-temple-base/commit/46c0968f156f45da0826ec038d71b5e735732805))

* fix windows not support ; to run ([6aedb96](https://github.com/bridgewwater/golang-project-temple-base/commit/6aedb96755afc185bcd96be378fcafe5a291e326))

## 1.1.0 (2021-01-02)

* docs: add auto remove useless document at tools shell ([696b6be](https://github.com/bridgewwater/golang-project-temple-base/commit/696b6be))

* update go-ubuntu.yml env set ([adf588f](https://github.com/bridgewwater/golang-project-temple-base/commit/adf588f))

## 1.0.0 (2021-01-02)

* ci: udpate docker build local ([b87cbcf](https://github.com/bridgewwater/golang-project-temple-base/commit/b87cbcf))

* ci(change to github action): let proxy set by local and add action of test coverage ([7d180a6](https://github.com/bridgewwater/golang-project-temple-base/commit/7d180a6))

* ci(update build script and mod dependencies): update github.com/stretchr/testify v1.6.1 ([4be787f](https://github.com/bridgewwater/golang-project-temple-base/commit/4be787f))

* add cloc task ([62a5af2](https://github.com/bridgewwater/golang-project-temple-base/commit/62a5af2))

* add codecov.yml for config code ([d2d0d19](https://github.com/bridgewwater/golang-project-temple-base/commit/d2d0d19))

* add depends of project helper at README.md ([fb017b3](https://github.com/bridgewwater/golang-project-temple-base/commit/fb017b3))

* add READM.md fast test case ([4bc128c](https://github.com/bridgewwater/golang-project-temple-base/commit/4bc128c))

* change base version v1.0.0 ([81d4e39](https://github.com/bridgewwater/golang-project-temple-base/commit/81d4e39))

* change docker-complse templ name for script ([6d8142d](https://github.com/bridgewwater/golang-project-temple-base/commit/6d8142d))

* change Makefile goproxy ([ad02ebd](https://github.com/bridgewwater/golang-project-temple-base/commit/ad02ebd))

* change to main and update temp-golang-base script ([77e3326](https://github.com/bridgewwater/golang-project-temple-base/commit/77e3326))

* Create go-ubuntu.yml ([c9da0e9](https://github.com/bridgewwater/golang-project-temple-base/commit/c9da0e9))

* first commit ([13ec011](https://github.com/bridgewwater/golang-project-temple-base/commit/13ec011))

* fix go mod private use ([1b5cd4a](https://github.com/bridgewwater/golang-project-temple-base/commit/1b5cd4a))

* let defualt LICENCE to MIT ([0386847](https://github.com/bridgewwater/golang-project-temple-base/commit/0386847))

* rebuild project base ([3bd2964](https://github.com/bridgewwater/golang-project-temple-base/commit/3bd2964))

* remove default MIT LICENC ([2f0437e](https://github.com/bridgewwater/golang-project-temple-base/commit/2f0437e))

* update .dockerignore ([eda64b4](https://github.com/bridgewwater/golang-project-temple-base/commit/eda64b4))

* update doc folder and change MakeDockerRun.mk help ([dd5b24a](https://github.com/bridgewwater/golang-project-temple-base/commit/dd5b24a))

* update help at MakeGoMod.mk ([9d12853](https://github.com/bridgewwater/golang-project-temple-base/commit/9d12853))

* update MakeDockerRun.mk and MakeDockerRun.mk ([25fb3e5](https://github.com/bridgewwater/golang-project-temple-base/commit/25fb3e5))

* update Makefile ([27f252a](https://github.com/bridgewwater/golang-project-temple-base/commit/27f252a))

* update MakeGoAction.mk show actionCodecovPush use ([62b5bfb](https://github.com/bridgewwater/golang-project-temple-base/commit/62b5bfb))

* update MakeGoTravis.mk new travisFile task for show travis file ([47c3d7b](https://github.com/bridgewwater/golang-project-temple-base/commit/47c3d7b))

* update README.md ([d1e4ae4](https://github.com/bridgewwater/golang-project-temple-base/commit/d1e4ae4))

* update README.md depends settings at private git ([fff6b87](https://github.com/bridgewwater/golang-project-temple-base/commit/fff6b87))

* update temple for test-case set by ENV_ROOT_TEST_INVERT_MATCH ([a0a456a](https://github.com/bridgewwater/golang-project-temple-base/commit/a0a456a))

* feat: add temp-golang-base for fast init golang project ([93d16b3](https://github.com/bridgewwater/golang-project-temple-base/commit/93d16b3))

* feat: change ignore clear for management lib version ([bc47d29](https://github.com/bridgewwater/golang-project-temple-base/commit/bc47d29))

* feat: change to travis-ci.com ([85b8d51](https://github.com/bridgewwater/golang-project-temple-base/commit/85b8d51))

* feat: update temp-golang-base ([d56783e](https://github.com/bridgewwater/golang-project-temple-base/commit/d56783e))

* feat: update temp-golang-base for support more case ([a2f9f17](https://github.com/bridgewwater/golang-project-temple-base/commit/a2f9f17))
