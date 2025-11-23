
BUILD_DIR = verilator_build_dir

VERILATOR := verilator
UVM_ROOT = /home/niels/uvm/uvm-verilator-uvm-2017-1.0

VERILATOR_JOBS ?= 4

SRC_DIR = src
UVC_DIR = $(SRC_DIR)/uvc
RTL_DIR = $(SRC_DIR)/rtl
IF_DIR = $(SRC_DIR)/if
TEST_DIR = test

SEED ?= $(shell date +%s)

RTL_FILES = $(wildcard $(SRC_DIR)/rtl/*.sv)
TEST_FILES = $(wildcard $(TEST_DIR)/*.sv)

TOP_NAME := test
BIN_NAME := test
UVM_TEST ?= cl_apb_tb_simple_test
UVM_FILES := -I$(UVM_ROOT)/src $(UVM_ROOT)/src/uvm_pkg.sv
INC_DIRS = -I$(PWD)/$(IF_DIR) -I$(PWD)/$(TEST_DIR) -I$(PWD)/$(UVC_DIR)
DEFINES := -DUVM_NO_DPI
WARNINGS = -Wno-lint -Wno-TIMESCALEMOD -Wno-SYMRSVDWORD -Wno-CONSTRAINTIGN
OTHER_FLAGS := --bbox-sys --timescale-override 1ns/1ps --assert

.default: run-test

clean:
	rm -rf verilator_build_dir

verilator_build_dir: 
		$(VERILATOR) --binary $(UVM_FILES) -f verilator.f $(DEFINES) $(WARNINGS) $(OTHER_FLAGS) --bbox-unsup  \
		--verilate-jobs $(VERILATOR_JOBS) --build-jobs $(VERILATOR_JOBS) -Mdir $(BUILD_DIR) --top-module tb_top src/tb/tb_top.sv \
		$(RTL_FILES) -CFLAGS -O0

run-test: verilator_build_dir
	./verilator_build_dir/Vtb_top +UVM_TESTNAME=$(UVM_TEST) +verilator+seed+$(SEED)

simulate: $(SIM_DIR)/$(BIN_NAME)
	$(SIM_DIR)/$(BIN_NAME) +UVM_TESTNAME=$(UVM_TEST) | tee $(TEMPFILE)
	@grep "^UVM_ERROR\\s*:\\s*0$$" $(TEMPFILE) -q
	@grep "^UVM_FATAL\\s*:\\s*0$$" $(TEMPFILE) -q
	@grep "^Test PASSED$$" $(TEMPFILE) -q

debug:
	@echo "SRC_FILES = $(SRC_FILES)"


.PHONY: simulate clean
