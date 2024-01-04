# Parser:
PARSER = xvlog
PARSER_FLAGS = -sv

# Elaborator:
ELABORATOR = xelab
TIMESCALE = 10ns/10ps
ELAB_FLAGS = --timescale $(TIMESCALE) --override_timeunit

# Simulator
SIMULATOR = xsim
SIM_FLAGS = -R

# Define directories
SRC_DIR = src
TB_DIR = tb
LIB_DIR = lib
BUILD_DIR = build
LOGS_DIR = logs
DATA_DIR = data

# Define source, testbench, and library files
SRC_FILES = $(wildcard $(SRC_DIR)/*.sv)
TB_FILES = $(wildcard $(TB_DIR)/*.sv)
LIB_FILES = $(wildcard $(LIB_DIR)/*)
OUTPUT_FILES = $(wildcard webtalk* *.jou *.log xvlog.* xelab.* xsim.* *.jou *.wdb $(LOGS_DIR)/*)

# Define the top-level module for simulation (usually the testbench)
TOP_MODULE = tb

# Targets
.PHONY: all parse elaborate simulate clean

all: simulate

# Compile source and testbench files
parse: $(SRC_FILES) $(TB_FILES)
	$(PARSER) $(PARSER_FLAGS) $(LIB_FILES) $(SRC_FILES)
	$(PARSER) $(PARSER_FLAGS) $(LIB_FILES) $(TB_FILES)

# Elaborate the top-level module
elaborate: parse
	$(ELABORATOR) $(ELAB_FLAGS) $(TOP_MODULE)

# Run simulation
simulate: elaborate
	$(SIMULATOR) $(SIM_FLAGS) $(TOP_MODULE)

# Clean up the build directory
clean:
	rm -rf $(BUILD_DIR)/*
	rm -rf ./xsim.dir
	rm -rf $(OUTPUT_FILES)
