# Directories
BUILD_DIR=./build
SRC_DIR=./src
MAN_DIR=$(SRC_DIR)/man/
PREFIX?=/usr/local/bin

BIN_NAME=ellipsis
MAN_PAGES=$(patsubst $(MAN_DIR)/%.md, $(BUILD_DIR)/share/%.gz, $(wildcard $(MAN_DIR)/*.md))

.PHONY: all
all: $(BUILD_DIR)/bin/$(BIN_NAME) $(MAN_PAGES)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: install
install: all
	install -D -m755 $(BUILD_DIR)/bin/$(BIN_NAME) -t $(PREFIX)/bin/

# Binary
$(BUILD_DIR)/bin/$(BIN_NAME): $(SRC_DIR)/$(BIN_NAME)
	shellcheck $^
	install $^ -DT $@

# Man Pages
$(BUILD_DIR)/share/%.gz: $(SRC_DIR)/man/%.md
	mkdir -p $(dir $@)
	pandoc --standalone --from=markdown --to=man $^ | gzip > $@

