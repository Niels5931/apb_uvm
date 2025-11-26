
`ifndef CL_APB_MONITOR_SVH
`define CL_APB_MONITOR_SVH

class cl_apb_monitor extends uvm_monitor;

    `uvm_component_utils(cl_apb_monitor)

    // Virtual interface
    virtual if_apb vif;

    // Analysis port to send observed transactions
    uvm_analysis_port #(cl_apb_seq_item) ap;

    // Configuration object
    cl_apb_config cfg;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(cl_apb_config)::get(this, "", "cfg", cfg)) begin
            `uvm_fatal("CONFIG", "Cannot get configuration object from uvm_config_db. Have you set it?")
        end
        ap = new("ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        cl_apb_seq_item req;
    endtask

endclass

`endif // CL_APB_MONITOR_SVH
