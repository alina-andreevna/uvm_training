class tst_base extends uvm_test;   
  `uvm_component_utils(tst_base)

  //----
  env           m_env;
  cfg_env       m_cfg_env;
  cfg_rst_gen   m_cfg_rst_gen0;
  cfg_clk_gen   m_cfg_clk_gen0;
  cfg_data_gen  m_cfg_data_gen0;
  cfg_coeffs_gen  m_cfg_coeffs_gen0;

  //----
  extern function      new(string name = "tst_base", uvm_component parent = null);
  extern function void start_of_simulation_phase(uvm_phase phase);
  extern function void build_phase(uvm_phase phase);
endclass: tst_base

//----
function tst_base::new(string name = "tst_base", uvm_component parent = null);
  super.new (name, parent);
  $timeformat(-9, 2, "ns", 5);
  uvm_test_done.set_drain_time(this, 500);
endfunction: new

//----
function void tst_base::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name(), "topology report", UVM_LOW);
  this.print();
endfunction

//----
function void tst_base::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_name(), "building", UVM_FULL);
  //----
  uvm_config_int::set(this, "*", "recording_detail", UVM_FULL);

  //---- rst configuration
  m_cfg_rst_gen0 = cfg_rst_gen::type_id::create("m_cfg_rst_gen0", this);
  uvm_config_db#(cfg_rst_gen)::set(this, "*m_rst_gen0*", "m_cfg", m_cfg_rst_gen0);

  //---- clk_gen configuration
  m_cfg_clk_gen0 = cfg_clk_gen::type_id::create("m_cfg_clk_gen0", this);
  uvm_config_db#(cfg_clk_gen)::set(this,"*m_clk_gen0*", "m_cfg", m_cfg_clk_gen0);

    //---- data_gen configuration
  m_cfg_data_gen0 = cfg_data_gen::type_id::create("m_cfg_data_gen0", this);
  uvm_config_db#(cfg_data_gen)::set(this,"*m_data_gen0*", "m_cfg", m_cfg_data_gen0);

  //---- coeffs_gen configuration
  m_cfg_coeffs_gen0 = cfg_coeffs_gen::type_id::create("m_cfg_coeffs_gen0", this);
  uvm_config_db#(cfg_coeffs_gen)::set(this,"*m_coeffs_gen0*", "m_cfg", m_cfg_coeffs_gen0);

  //---- configurate test env
  m_cfg_env = cfg_env::type_id::create("m_cfg_env");
  // m_cfg_env.en_scbrd            = UVM_PASSIVE;
  uvm_config_db #(cfg_env)::set(this, "*m_env*", "m_cfg", m_cfg_env);

endfunction
