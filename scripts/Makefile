
BUILD_DIR = verilator_build_dir

VERILATOR := verilator
UVM_ROOT = /home/niels/projects/uvm/common/uvm-2017-install/uvm-verilator-2017-1.0/

SRC_FILES = src/ 
TEST_DIR = test
TEST_FILES = $(wildcard $(TEST_DIR)/*.sv)


TOP_NAME := test
BIN_NAME := test
UVM_TEST ?= cl_uvm_simple_test
UVM_FILES := -I$(UVM_ROOT)/src $(UVM_ROOT)/src/uvm_pkg.sv
DEFINES := -DUVM_NO_DPI
WARNINGS = -Wno-lint -Wno-TIMESCALEMOD -Wno-SYMRSVDWORD -Wno-CONSTRAINTIGN
OTHER_FLAGS := --bbox-sys --timescale-override 1ns/1ps --assert

clean:
	rm -rf verilator_build_dir

build-verilator: 
		$(VERILATOR) --binary $(UVM_FILES) $(DEFINES) $(WARNINGS) $(OTHER_FLAGS) \
		+incdir+$(PWD)/test \
		--verilate-jobs 4 --build-jobs 4 -Mdir $(BUILD_DIR) --top-module tb_top $(TEST_FILES)

simulate: $(SIM_DIR)/$(BIN_NAME)
	$(SIM_DIR)/$(BIN_NAME) +UVM_TESTNAME=$(UVM_TEST) | tee $(TEMPFILE)
	@grep "^UVM_ERROR\\s*:\\s*0$$" $(TEMPFILE) -q
	@grep "^UVM_FATAL\\s*:\\s*0$$" $(TEMPFILE) -q
	@grep "^Test PASSED$$" $(TEMPFILE) -q

.PHONY: simulate clean
