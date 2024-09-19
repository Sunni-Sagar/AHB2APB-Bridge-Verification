class ahb_mon extends uvm_monitor;
  `uvm_component_utils(ahb_mon);
  
  //virtual interface
  virtual ahb_interface.AHB_MON vif;
 //analysis port 
  ahb_agent_config ahb_config;
  
  uvm_analysis_port#(ahb_xtn)monitor_port;
  
  function new ( string name = " ahb_mon",uvm_component parent);
    super.new(name,parent);
    monitor_port=new("monitor_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_config))
      `uvm_fatal("AHB MON","AHB_CONFIG NOT GET");
  endfunction

  function void connect_phase(uvm_phase phase);
    vif=ahb_config.vif;
  endfunction
  //task run phase
  task run_phase(uvm_phase phase);
    @(vif.ahb_mon);  
    forever  collect_data();
  endtask
  
  task collect_data;
  
  ahb_xtn xtn;
  xtn = ahb_xtn::type_id::create("xtn");
  wait(vif.ahb_mon.Hreadyout && (vif.ahb_mon.Htrans == 2'b10 || vif.ahb_mon.Htrans == 2'b11))
  xtn.Htrans = vif.ahb_mon.Htrans;
  xtn.Hwrite = vif.ahb_mon.Hwrite;
  xtn.Hreadyin = vif.ahb_mon.Hreadyin;
  xtn.Hsize  = vif.ahb_mon.Hsize;
  xtn.Haddr  = vif.ahb_mon.Haddr; 
  @(vif.ahb_mon);
  wait(vif.ahb_mon.Hreadyout && (vif.ahb_mon.Htrans == 2'b10 || vif.ahb_mon.Htrans == 2'b11))
  if (vif.ahb_mon.Hwrite == 1'b1)
    xtn.Hwdata = vif.ahb_mon.Hwdata;
  else
    xtn.Hrdata = vif.ahb_mon.Hrdata;
  $display("time : %0t",$time);
xtn.print();
  monitor_port.write(xtn);
endtask


endclass
  
