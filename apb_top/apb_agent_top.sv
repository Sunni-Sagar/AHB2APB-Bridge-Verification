class apb_agent_top extends uvm_env;
  `uvm_component_utils(apb_agent_top);

  apb_agent agth;

  function new (string name="apb_agent_top",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agth=apb_agent::type_id::create("agnth",this);
  endfunction

endclass

