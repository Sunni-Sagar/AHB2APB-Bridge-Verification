class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent);

  apb_agent_config apb_cfg;
  apb_mon monh;
  apb_driver drvh;
  apb_sequencer seqrh;

  function new (string name="apb_agent",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
      `uvm_fatal("apb agent","config not get");
    monh=apb_mon::type_id::create("monh",this);

    if(apb_cfg.is_active==UVM_ACTIVE)
      begin
        drvh=apb_driver::type_id::create("drvh",this);
        seqrh=apb_sequencer::type_id::create("seqrh",this);
      end
  endfunction

  function void connect_phase(uvm_phase phase);
    if(apb_cfg.is_active==UVM_ACTIVE)
      drvh.seq_item_port.connect(seqrh.seq_item_export);
  endfunction
endclass

