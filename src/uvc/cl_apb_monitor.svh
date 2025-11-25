
`ifndef CL_APB_MONITOR_SVH
`define CL_APB_MONITOR_SVH

class cl_apb_monitor extends uvm_monitor;

    `uvm_component_utils(cl_apb_monitor)

    // Virtual interface
    virtual apb_if apb_vif;

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
        if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", apb_vif)) begin
            `uvm_fatal("VIF", "Cannot get virtual interface from uvm_config_db. Have you set it?")
        end
        ap = new("ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        cl_apb_seq_item req;
        forever begin
            // Wait for PSEL and PENABLE to indicate a transaction
            @(posedge apb_vif.PCLK);
            if (apb_vif.PSEL && apb_vif.PENABLE) begin
                req = cl_apb_seq_item::type_id::create("req");
                // Sample APB signals
                req.paddr = apb_vif.PADDR;
                req.pwdata = apb_vif.PWDATA;
                req.pwrite = apb_vif.PWRITE;
                req.pslverr = apb_vif.PSLVERR;
                req.prdata = apb_vif.PRDATA; // Sample PRDATA for read transactions

                // Determine if it's a read or write transaction based on PWRITE
                if (req.pwrite) begin
                    `uvm_info("MONITOR", $sformatf("Observed APB Write: PADDR=0x%0h, PWDATA=0x%0h", req.paddr, req.pwdata), UVM_LOW)
                end else begin
                    `uvm_info("MONITOR", $sformatf("Observed APB Read: PADDR=0x%0h, PRDATA=0x%0h", req.paddr, req.prdata), UVM_LOW)
                end
                ap.write(req);
            end
        end
    endtask

endclass

`endif // CL_APB_MONITOR_SVH
