class tst_start extends tst_base;
  `uvm_component_utils(tst_start)
  //----
  extern function      new(string name = "tst_start", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
endclass: tst_start

//----
function tst_start::new(string name = "tst_start", uvm_component parent = null);
  super.new (name, parent);
endfunction: new

//----
function void tst_start::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  //---- modification
  // m_cfg_env.scbrd_en_rpt_in_hoarder   = '1;
  // m_cfg_env.scbrd_en_rpt_in_analyzer  = '0;
  m_cfg_clk_gen0.vrb_lvl_drv          = UVM_LOW;
  m_cfg_rst_gen0.vrb_lvl_drv          = UVM_LOW;
  m_cfg_data_gen0.vrb_lvl_drv         = UVM_LOW;
  m_cfg_coeffs_gen0.vrb_lvl_drv       = UVM_LOW;
  //---- saving
  uvm_config_db#(cfg_env)::set(this, "*m_env*", "m_cfg", m_cfg_env);
  uvm_config_db#(cfg_clk_gen)::set(this, "*m_clk_gen0*", "m_cfg", m_cfg_clk_gen0);
  uvm_config_db#(cfg_rst_gen)::set(this, "*m_rst_gen0*", "m_cfg", m_cfg_rst_gen0);
  uvm_config_db#(cfg_data_gen)::set(this, "*m_cfg_data_gen*", "m_cfg", m_cfg_data_gen0);
  uvm_config_db#(cfg_coeffs_gen)::set(this, "*m_cfg_coeffs_gen*", "m_cfg", m_cfg_coeffs_gen0);
  //---- create test environment
  m_env = env::type_id::create("m_env", this);
  //----
  uvm_config_db#(uvm_object_wrapper)::set(this,"m_env.m_vsqr.run_phase", "default_sequence", sq_start::type_id::get());
endfunction: build_phase