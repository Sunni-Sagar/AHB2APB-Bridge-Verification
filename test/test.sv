class test extends uvm_test;
  `uvm_component_utils(test)
  env envh;
  env_config env_cfg;
  ahb_agent_config ahb_agent_cfg;
  apb_agent_config apb_agent_cfg;
  
  bit has_ragent = 1;
  bit has_wagent = 1;
  
  function new(string name = "test" , uvm_component parent);
	super.new(name,parent);
  endfunction

  function void config_ram();
    if (has_wagent)
      begin 
        ahb_agent_cfg.is_active = UVM_ACTIVE;
        if(!uvm_config_db #(virtual ahb_interface)::get(this,"","ahb_if",ahb_agent_cfg.vif))
          `uvm_fatal("test VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")
          env_cfg.ahb_agent_cfg = ahb_agent_cfg;
      end
    
    if(has_ragent) 
      begin
        apb_agent_cfg.is_active = UVM_ACTIVE;
        if(!uvm_config_db #(virtual apb_interface)::get(this,"","apb_if",apb_agent_cfg.vif))
         `uvm_fatal("test VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")
          env_cfg.apb_agent_cfg = apb_agent_cfg;
      end
    env_cfg.has_wagent = has_wagent;
    env_cfg.has_ragent = has_ragent;
    uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);
  endfunction

  function void build_phase(uvm_phase phase);
    env_cfg=env_config::type_id::create("env_cfg");
    
    if(has_wagent)
      ahb_agent_cfg=ahb_agent_config::type_id::create("ahb_agent_cfg");
    if(has_ragent)
      apb_agent_cfg=apb_agent_config::type_id::create("apb_agent_cfg");
    
    config_ram();
    
    super.build_phase(phase);
    envh=env::type_id::create("envh", this);
  endfunction

endclass

class single_vseq extends test;
  `uvm_component_utils(single_vseq);
  
  v_seq1 vseq1;
  
  function new (string name="single_vseq",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq1=v_seq1::type_id::create("vseq1");
    vseq1.start(envh.v_seqrh);
 #90;
   phase.drop_objection(this);
  endtask  
endclass

class incr_test extends test;
  `uvm_component_utils(incr_test);

  v_seq2 vseq2;

  function new (string name="incr_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq2=v_seq2::type_id::create("vseq2");
    vseq2.start(envh.v_seqrh);
#100;
    phase.drop_objection(this);
  endtask
endclass


class wrap4_test extends test;
  `uvm_component_utils(wrap4_test);

  v_seq3 vseq3;

  function new (string name="wrap4_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq3=v_seq3::type_id::create("vseq3");
    vseq3.start(envh.v_seqrh);
#200;   
 phase.drop_objection(this);
  endtask
endclass

class wrap8_test extends test;
  `uvm_component_utils(wrap8_test);

  v_seq4 vseq4;

  function new (string name="wrap8_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq4=v_seq4::type_id::create("vseq4");
    vseq4.start(envh.v_seqrh);
   #130;
 phase.drop_objection(this);
  endtask
endclass

class wrap16_test extends test;
  `uvm_component_utils(wrap16_test);

  v_seq5 vseq5;

  function new (string name="wrap16_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq5=v_seq5::type_id::create("vseq5");
    vseq5.start(envh.v_seqrh);
 #120;
  phase.drop_objection(this);
  endtask
endclass

class wrap16_cov_test extends test;
  `uvm_component_utils(wrap16_cov_test);

  v_seq6 vseq6;

  function new (string name="wrap16_cov_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq6=v_seq6::type_id::create("vseq6");
    vseq6.start(envh.v_seqrh);
 #120;
  phase.drop_objection(this);
  endtask
endclass

class wrap16_cov1_test extends test;
  `uvm_component_utils(wrap16_cov1_test);

  v_seq7 vseq7;

  function new (string name="wrap16_cov1_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    vseq7=v_seq7::type_id::create("vseq7");
    vseq7.start(envh.v_seqrh);
 #120;
  phase.drop_objection(this);
  endtask
endclass

