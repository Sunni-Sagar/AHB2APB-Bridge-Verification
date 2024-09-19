class env_config extends uvm_object;
`uvm_object_utils(env_config)

bit has_functional_coverage = 0;
bit has_wagent_functional_coverage = 0;
bit has_scoreboard = 1;
bit has_wagent = 1;
bit has_ragent = 1;
bit has_virtual_sequencer = 1;

ahb_agent_config ahb_agent_cfg;
apb_agent_config apb_agent_cfg;


function new(string name = "env_config");
  super.new(name);
endfunction

endclass


