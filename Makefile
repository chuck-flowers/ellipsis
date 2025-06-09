BIN_NAME=ellipsis

BUILD_DIR=./build
SRC_DIR=./src
PREFIX?=/usr/local/bin

.PHONY: all
all: $(BUILD_DIR)/bin/$(BIN_NAME)

$(BUILD_DIR)/bin/$(BIN_NAME): $(SRC_DIR)/$(BIN_NAME)
	shellcheck $^
	install $^ -DT $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: install
install:
	install -DT -m755 $(BUILD_DIR)/bin/$(BIN_NAME) $(PREFIX)/bin/

