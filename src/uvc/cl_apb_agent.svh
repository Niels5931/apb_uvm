class cl_apb_agent extends uvm_agent;

  cl_apb_driver_base              driver;
  cl_apb_monitor                  monitor;
  cl_apb_config                   cfg;
  uvm_sequencer#(cl_apb_seq_item) sequencer;
  uvm_analysis_port #(cl_apb_seq_item) ap;

  `uvm_component_utils(cl_apb_agent)

  function new(string name = "cl_apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(cl_apb_config)::get(this,"","cfg",this.cfg)) begin
      `uvm_fatal("APB Agent", "Could not find config object")
    end

    if (this.cfg.active == pk_apb::ACTIVE) begin
        if (this.cfg.driver == pk_apb::MASTER) begin
          uvm_config_db#(cl_apb_config)::set(this, "mgmt_driver", "cfg", this.cfg);
          if(!uvm_config_db#(virtual if_apb.master)::get(this, "", "vif", this.cfg.vif)) begin
            `uvm_fatal("APB Agent", "Could not find virtual interface for master agent")
          end
          this.driver = cl_apb_driver_manager::type_id::create("mgmt_driver",this);
        end else if (this.cfg.driver == pk_apb::SLAVE) begin
          uvm_config_db#(cl_apb_config)::set(this, "sbnt_driver", "cfg", this.cfg);
          if(!uvm_config_db#(virtual if_apb.slave)::get(this, "", "vif", this.cfg.vif)) begin
            `uvm_fatal("APB Agent", "Could not find virtual interface for subordinate agent")
          end
          this.driver = cl_apb_driver_subordinate::type_id::create("sbnt_driver",this);
        end else begin
          `uvm_fatal("APB Agent", "Error! Please choose a driver type for agent")
        end
      uvm_config_db#(cl_apb_config)::set(this, "monitor", "cfg", this.cfg);
      if(!uvm_config_db#(virtual if_apb.master)::get(this, "", "vif", this.cfg.vif)) begin
        `uvm_fatal("APB Agent", "Could not find virtual interface for monitor")
      end
      this.sequencer = uvm_sequencer#(cl_apb_seq_item)::type_id::create("sequencer",this);
    end
    this.monitor = cl_apb_monitor::type_id::create("monitor", this);
    this.ap = new("ap",this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (this.cfg.active == pk_apb::ACTIVE) begin
      this.driver.seq_item_port.connect(this.sequencer.seq_item_export);
    end
    this.monitor.ap.connect(this.ap);
  endfunction : connect_phase

endclass : cl_apb_agent
