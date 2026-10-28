CXX      := g++
CXXFLAGS := -O3
CPPFLAGS :=
LDLIBS   := -lX11 -lxkbfile

PREFIX   ?= /usr/local
PROFILE  ?= Release

TARGET   := getxkblayout

SRC_DIR  := src
BUILD_DIR:= build/$(PROFILE)

SRCS     := $(wildcard $(SRC_DIR)/*.cpp)
OBJS     := $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

.PHONY: all clean

all: clean $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $(BUILD_DIR)/$@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR) $(TARGET)

install:
	install -m 0755 $(BUILD_DIR)/$(TARGET) $(PREFIX)/bin/

uninstall:
	rm $(PREFIX)/bin/$(TARGET)
