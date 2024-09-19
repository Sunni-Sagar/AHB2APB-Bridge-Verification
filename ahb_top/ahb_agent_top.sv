class ahb_agent_top extends uvm_env;
  `uvm_component_utils(ahb_agent_top);
  
  ahb_agent agth;
  
  function new (string name="ahb_agent_top",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agth=ahb_agent::type_id::create("agnth",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    uvm_top.print_topology;
  endtask
  
endclass
