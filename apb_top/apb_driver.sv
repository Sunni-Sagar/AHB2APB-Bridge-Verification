class apb_driver extends uvm_driver#(apb_xtn);
  `uvm_component_utils(apb_driver);

  //virtual interface
  virtual apb_interface.APB_DRV vif;

  apb_agent_config apb_config;

  function new ( string name = " apb_driver",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //get config for vif
     if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_config))
      `uvm_fatal("APB DRV","APB_CONFIG NOT GET");

  endfunction

  //function void connect phase
  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=apb_config.vif;
  endfunction
   //task run phase
task run_phase(uvm_phase phase);
  req = apb_xtn::type_id::create("req", this);
  forever send_to_dut(req);
endtask

///----send to dut------/////
task send_to_dut(apb_xtn xtn);
  wait(vif.apb_drv.Pselx != 0) 
  if(vif.apb_drv.Pwrite == 0)
    if(vif.apb_drv.Penable)
    vif.apb_drv.Prdata <= {$urandom};;
    repeat(2) @(vif.apb_drv);
endtask
endclass


