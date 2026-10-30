CXX      := g++
CPPFLAGS :=
LDFLAGS  := 
LDLIBS   := -lX11 -lxkbfile

PREFIX   ?= /usr/local
BINDIR   ?= $(PREFIX)/bin
PROFILE  ?= Release

TARGET   := getxkblayout

SRC_DIR  := src
BUILD_DIR:= build/$(PROFILE)

# ─── PROFILE CONFIGURATION ──────────────────────────────────────────
# Dynamically adjusts flags based on the chosen profile
ifeq ($(PROFILE),Debug)
    CXXFLAGS := -O0 -g3 -DDEBUG -Wall -Wextra -std=c++20
else
    CXXFLAGS := -O3 -Wall -Wextra -DNDEBUG -std=c++20
endif
# ────────────────────────────────────────────────────────────────────

SRCS     := $(wildcard $(SRC_DIR)/*.cpp)
OBJS     := $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

.PHONY: all clean install uninstall

all: $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR)/$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf build/

install: all
	install -d $(DESTDIR)$(BINDIR)
	install -m 0755 $(BUILD_DIR)/$(TARGET) $(DESTDIR)$(BINDIR)/

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(TARGET)
