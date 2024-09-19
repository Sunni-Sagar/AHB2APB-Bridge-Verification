class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent);
  
  ahb_agent_config ahb_cfg;
  ahb_mon monh;
  ahb_driver drvh;
  ahb_sequencer seqrh;
  
  function new (string name="ahb_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
      `uvm_fatal("ahb agent","config not get");
    monh=ahb_mon::type_id::create("monh",this);
    
    if(ahb_cfg.is_active==UVM_ACTIVE)
      begin
        drvh=ahb_driver::type_id::create("drvh",this);
        seqrh=ahb_sequencer::type_id::create("seqrh",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(ahb_cfg.is_active==UVM_ACTIVE)
      drvh.seq_item_port.connect(seqrh.seq_item_export);
  endfunction
endclass                                           
       
       
