package bridge_test_pkg;
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "ahb_agent_config.sv"
`include "apb_agent_config.sv"
`include "env_config.sv"

`include "ahb_xtn.sv"
`include "ahb_driver.sv"
`include "ahb_mon.sv"
`include "ahb_sequencer.sv"
`include "ahb_agent.sv"
`include "ahb_agent_top.sv"
`include "ahb_seq.sv"

`include "apb_xtn.sv"
`include "apb_driver.sv"
`include "apb_mon.sv"
`include "apb_sequencer.sv"
`include "apb_agent.sv"
`include "apb_agent_top.sv"
//`include "apb_seq.sv"

`include "v_sequencer.sv"
`include "v_seq.sv"
`include "scoreboard.sv"

`include "env.sv"
`include "test.sv"

endpackage
