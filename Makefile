ROOT := $(shell git rev-parse --show-toplevel)
FLUTTER := $(shell which flutter)
FLUTTER_BIN_DIR := $(shell dirname $(FLUTTER))
FLUTTER_DIR := $(FLUTTER_BIN_DIR:/bin=)
DART := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dart
DART_FMT := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dartfmt
DART_FIX := $(shell which dartfix)

.PHONY: analyze
analyze:
	$(FLUTTER) analyze

.PHONY: format
format:
	$(DART_FMT) -l 220 -w ./

.PHONY: lint
lint:
	pub global activate dartfix
	$(DART_FIX) ./lib --fix=prefer_single_quotes --overwrite
	$(DART_FIX) ./lib --fix=unnecessary_this --overwrite
	$(DART_FIX) ./lib --fix=unnecessary_new --overwrite
	$(MAKE) format

.PHONY: test
test:
	$(FLUTTER) test

.PHONY: list-outdated
list-outdated:
	$(FLUTTER) pub outdated

.PHONY: upgrade-resolvable
upgrade-resolvable:
	$(FLUTTER) pub upgrade --major-versions
