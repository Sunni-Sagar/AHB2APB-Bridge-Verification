class apb_mon extends uvm_monitor;
  `uvm_component_utils(apb_mon);

  //virtual interface
  virtual apb_interface.APB_MON vif;

	//analysis port
 uvm_analysis_port#(apb_xtn)monitor_port;
	
  apb_agent_config apb_config;

  function new ( string name = " apb_mon",uvm_component parent);
    super.new(name,parent);
    monitor_port=new("monitor_port",this);
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
  forever collect_data();
endtask

task collect_data();
  apb_xtn xtn;
  xtn = apb_xtn::type_id::create("xtn");
  wait(vif.apb_mon.Penable)
  xtn.Paddr = vif.apb_mon.Paddr;
  xtn.Pwrite = vif.apb_mon.Pwrite; 
  xtn.Pselx = vif.apb_mon.Pselx;
  if(xtn.Pwrite == 1)
    xtn.Pwdata = vif.apb_mon.Pwdata; 
  else
    xtn.Prdata = vif.apb_mon.Prdata;
   @(vif.apb_mon); //give 1 cycle delay - Setup + enable
   $display("apb mon  print at %0t",$time);
  xtn.print();
  monitor_port.write(xtn);
endtask
endclass

