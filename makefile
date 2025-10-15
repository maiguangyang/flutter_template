projectName = $(shell grep '"projectName"' lib/config/config.dart | awk -F'"' '{print $$4}')
macAppName = $(shell grep '"appName"' lib/config/config.dart | awk -F'"' '{print $$4}')
defaultVersion = $(shell grep '"version"' lib/config/config.dart | awk -F'"' '{print $$4}')
env = $(shell grep '"env"' lib/config/config.dart | awk -F'"' '{print $$4}')

fixed_timestamp := $(shell date +"%m%d%H")
timestamp = $(fixed_timestamp)

dirPath = ./build/macos/Build/Products/Release
distPath = ./dist

# make build all version=xxxx
combined_variable := $(defaultVersion)_$(timestamp)

ifdef version
combined_variable = $(version)
endif

flavor := uat
ifeq ($(env), prd)
flavor = prd
endif

# exportMethod := ad-hoc
exportMethod := development
ifeq ($(env), prd)
exportMethod = app-store
endif

# build number
buildNumber := 1
ifdef number
buildNumber = $(number)
endif

# 最终编译打包出来的文件名
buildAppFileName = $(projectName)-$(env)

# TODO 暂时注释，后续使用没问题整个删除
# ifeq ($(env), prd)
# buildAppFileName = $(projectName)-prd
# endif

appFileName = $(distPath)/$(buildAppFileName)_$(combined_variable)

# flutter版本处理
FLUTTER= flutter

# 如果不是dev环境，使用环境变量FLUTTER_DIR
ifneq ($(env), dev)
	FLUTTER_BIN=$$FLUTTER_DIR/bin
	FLUTTER=PATH=$(FLUTTER_BIN):$$PATH flutter
endif

app:
	make mac && make ipa && make apk

mac:
	make quit
	@$(FLUTTER) build macos --release --no-tree-shake-icons --build-name=$(combined_variable) --build-number=$(buildNumber) && make dmg

dmg:
	rm -rf "$(dirPath)/$(macAppName).dmg" && hdiutil create -size 100m -fs APFS -volname "$(macAppName)" -attach "$(dirPath)/$(macAppName).dmg" && make copy && make ln && make quit && make format

copy:
	cp -R "$(dirPath)/$(macAppName).app" "/Volumes/$(macAppName)/" && sleep 2;

ln:
	ln -s /Applications "/Volumes/$(macAppName)/Applications"

quit:
	disk_path=$$(hdiutil info | grep "$(macAppName)" | grep "/dev/disk" | awk '{print $$1}'); \
	if [ -n "$$disk_path" ]; then \
		hdiutil detach $$disk_path; \
	fi

format:
	make create_dist && rm -rf $(distPath)/$(buildAppFileName)_*.dmg && hdiutil convert "$(dirPath)/$(macAppName).dmg" -format UDZO -o $(appFileName).dmg && rm -rf "$(dirPath)/$(macAppName).dmg"

apk:
	@$(FLUTTER) build apk --build-name=$(combined_variable) --build-number=$(buildNumber) && make zipApk

zipApk:
	make create_dist && rm -rf $(distPath)/$(buildAppFileName)_*.apk && cp -f build/app/outputs/flutter-apk/app-release.apk $(appFileName).apk

ipa:
	@$(FLUTTER) build ipa --release --build-name=$(combined_variable) --build-number=$(buildNumber) --export-method=$(exportMethod) && make zipIpa

zipIpa:
	make create_dist && rm -rf $(distPath)/$(buildAppFileName)_*.ipa && cp -f "build/ios/ipa/$(projectName).ipa" $(appFileName).ipa

delete_dist:
	rm -rf $(distPath)

create_dist:
	make delete_dist
	if [ ! -d "$(distPath)" ]; then mkdir $(distPath); fi

html:
	@$(FLUTTER) build web --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/ --no-tree-shake-icons --no-tree-shake-icons --release && make nginx && make zipHtml

zipHtml:
	tar -cJf $(appFileName).tar.xz -C build/web .

code:
	make version
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs

config:
	dart ./scripts/build_cli.dart projectName="$(name)"
	dart run flutter_launcher_icons

l10n:
	make version
	rm -rf ./lib/core/l10n/*.arb && dart ./scripts/generate_l10n.dart 
	@$(FLUTTER) gen-l10n

icon:
	make version
	dart scripts/generate_icon.dart

nginx:
	dart ./scripts/generate_vhosts.dart path=lib/config/nginx_config.json

start:
	@$(FLUTTER) run -d chrome --web-renderer canvaskit --web-port=1988

install:
	make version
	@$(FLUTTER) pub get

version:
	make install_figlet
	@clear
	@printf "\n"
	@if command -v figlet >/dev/null 2>&1; then \
		printf "\033[32m"; \
		figlet "$(macAppName)"; \
		printf "\033[0m\n"; \
	fi
	@$(FLUTTER) --version | sed 's/^/\x1b[32m/' ; echo "\033[0m"

install_figlet:
	@if command -v brew >/dev/null 2>&1 && ! command -v figlet >/dev/null 2>&1; then \
		brew install figlet; \
	fi
	@clear


