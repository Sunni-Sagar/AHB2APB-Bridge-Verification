class env extends uvm_env;
  `uvm_component_utils(env)
  ahb_agent_top ahb_agt_top;
  apb_agent_top apb_agt_top;
  v_sequencer v_seqrh;
  scoreboard sb;
  env_config env_cfg;
  
  function new(string name = "env", uvm_component parent);
	super.new(name,parent);
endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
      `uvm_fatal("env","config cannot get() ");
    if(env_cfg.has_wagent)
      begin
        uvm_config_db #(ahb_agent_config)::set(this,"ahb_agt_top*","ahb_agent_config",env_cfg.ahb_agent_cfg);
        ahb_agt_top=ahb_agent_top::type_id::create("ahb_agt_top",this);
      end
    if(env_cfg.has_ragent)
      begin
        uvm_config_db #(apb_agent_config)::set(this,"apb_agt_top*","apb_agent_config",env_cfg.apb_agent_cfg);
        apb_agt_top=apb_agent_top::type_id::create("apb_agt_top",this);
      end
    super.build_phase(phase);
    if(env_cfg.has_virtual_sequencer)
      v_seqrh=v_sequencer::type_id::create("v_seqrh",this);
    if(env_cfg.has_scoreboard)
      sb=scoreboard::type_id::create("sb",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(env_cfg.has_virtual_sequencer)
      begin
        if(env_cfg.has_wagent)
          v_seqrh.ahb_seqrh = ahb_agt_top.agth.seqrh;
       // if(m_cfg.has_ragent)
        //  v_sequencer.rd_seqr = ragt_top.agnth.seqrh;
      end
    //if(m_cfg.has_scoreboard)
     // begin
        ahb_agt_top.agth.monh.monitor_port.connect(sb.ahb_fifo.analysis_export);
        apb_agt_top.agth.monh.monitor_port.connect(sb.apb_fifo.analysis_export);
     // end
  endfunction
endclass

