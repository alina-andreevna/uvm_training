class sqr_coeffs_gen extends uvm_sequencer #(sqi_coeffs_gen);
  `uvm_component_utils(sqr_coeffs_gen)
  //----
  cfg_coeffs_gen m_cfg;
  uvm_verbosity local_vrb_lvl = UVM_LOW;
  //----
  extern function       new(string name = "sqr_coeffs_gen", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
endclass: sqr_coeffs_gen

//----
function sqr_coeffs_gen::new(string name = "sqr_coeffs_gen", uvm_component parent = null);
  super.new(name, parent);
endfunction

//----
function void sqr_coeffs_gen::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  super.build_phase(phase);
  if (!uvm_config_db #(cfg_coeffs_gen)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(get_name(), UVC_COEFFS_RPTS_CFG_GETTING_FAILURE)
  local_vrb_lvl = m_cfg.vrb_lvl_sqr;
endfunction: build_phase
