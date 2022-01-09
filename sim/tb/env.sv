class env extends uvm_env;
  //----
  `uvm_component_utils(env)
  //----
  cfg_env     m_cfg;

  ag_rst_gen #("rst_gen_0") m_rst_gen0;
  ag_clk_gen #("clk_gen_0") m_clk_gen0;
  ag_data_gen #("data_gen_0") m_data_gen0;
  ag_coeffs_gen #("coeffs_gen_0") m_coeffs_gen0;
  // scbrd_ahb   m_scbrd;
  vsqr        m_vsqr;
  //---- ral
  //----
  extern function       new(string name = "env", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern function void  connect_phase(uvm_phase phase);
endclass : env

//----
function env::new(string name = "env", uvm_component parent = null);
  super.new(name, parent);
endfunction

//----
function void env::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  super.build_phase(phase);
  //---- get cfg
  if (!uvm_config_db #(cfg_env)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(get_name(), TB_RPTS_CFG_GETTING_FAILURE)
  //---- create objects
  m_rst_gen0  = ag_rst_gen #("rst_gen_0")::type_id::create("m_rst_gen0", this);
  m_clk_gen0  = ag_clk_gen #("clk_gen_0")::type_id::create("m_clk_gen0", this);
  m_data_gen0 = ag_data_gen #("data_gen_0")::type_id::create("m_data_gen0", this);
  m_coeffs_gen0 = ag_coeffs_gen #("coeffs_gen_0")::type_id::create("m_coeffs_gen0", this);
  m_vsqr      = vsqr::type_id::create("m_vsqr", this);
  // if(m_cfg.en_scbrd == UVM_ACTIVE) begin
  //   m_scbrd = scbrd::type_id::create("m_scbrd", this);
  // end
endfunction

//----
function void env::connect_phase(uvm_phase phase);
  `uvm_info(get_name(), "connect phase", UVM_FULL);
  super.connect_phase(phase);
  //----
  m_vsqr.m_sqr_rst_gen0 = m_rst_gen0.m_sqr;
  m_vsqr.m_sqr_clk_gen0 = m_clk_gen0.m_sqr;
  m_vsqr.m_sqr_data_gen0  = m_data_gen0.m_sqr;
  m_vsqr.m_sqr_coeffs_gen0  = m_coeffs_gen0.m_sqr;
endfunction
