class cl_apb_agent extends uvm_agent;

  cl_apb_driver_base              driver;
  cl_apb_config                   cfg;
  uvm_sequencer#(cl_apb_seq_item) sequencer;

  `uvm_component_utils(cl_apb_agent)

  function new(string name = "cl_apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (this.cfg.driver == pk_apb::MASTER) begin
      this.driver = cl_apb_driver_manager::type_id::create("mgmt driver",this);
    end else if (this.cfg.driver == pk_apb::SLAVE) begin
      `uvm_fatal("APB Agent", "Error! Slave driver not implemnted yet")
    end else begin
      `uvm_fatal("APB Agent", "Error! Please choose a driver type for agent")
    end

    this.sequencer = uvm_sequencer#(cl_apb_seq_item)::type_id::create();

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (this.cfg.active == pk_apb::ACTIVE) begin
      this.driver.seq_item_port.connect(this.sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : cl_apb_agent
