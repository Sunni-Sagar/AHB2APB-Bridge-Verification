class ahb_driver extends uvm_driver#(ahb_xtn);
  `uvm_component_utils(ahb_driver);
  
  //virtual interface
  virtual ahb_interface.AHB_DRV vif;  
  ahb_agent_config ahb_config;
  
  function new ( string name = " ahb_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //get config for vif
    if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_config))
      `uvm_fatal("AHB DRV","AHB_CONFIG NOT GET");
  endfunction
  
  //function void connect phase
 function void connect_phase(uvm_phase phase);
    vif=ahb_config.vif;
endfunction
  //task run phase
  task run_phase(uvm_phase phase);
    @(vif.ahb_drv);
    vif.ahb_drv.Hresetn <= 1'b0;
    @(vif.ahb_drv);
    vif.ahb_drv.Hresetn <= 1'b1;
    forever
      begin
        seq_item_port.get_next_item(req);
        `uvm_info("AHB_DRIVER","DATA SENT TO DUT",UVM_MEDIUM)
	req.print();
	send_to_dut(req);
	seq_item_port.item_done();
      end
  endtask
task send_to_dut(ahb_xtn req);
    vif.ahb_drv.Hwrite  <= req.Hwrite;
    vif.ahb_drv.Htrans  <= req.Htrans;
    vif.ahb_drv.Hsize   <= req.Hsize;
    vif.ahb_drv.Haddr   <= req.Haddr;
    vif.ahb_drv.Hreadyin<= 1'b1;
    @(vif.ahb_drv);
    wait(vif.ahb_drv.Hreadyout)
    if(req.Hwrite==1)
      vif.ahb_drv.Hwdata<=req.Hwdata;
    else
      vif.ahb_drv.Hwdata<=0;
endtask

endclass
  
