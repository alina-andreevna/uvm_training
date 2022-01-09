class cfg_coeffs_gen extends uvm_object;
  `uvm_object_utils(cfg_coeffs_gen)
  //----
  uvm_active_passive_enum active            = UVM_ACTIVE;
  //---- verbosity levels and reports
  uvm_verbosity vrb_lvl_mon = UVM_HIGH; //UVM_LOW UVM_HIGH
  uvm_verbosity vrb_lvl_drv = UVM_HIGH; //UVM_LOW UVM_HIGH
  uvm_verbosity vrb_lvl_sqr = UVM_HIGH; //UVM_LOW UVM_HIGH
  //----
  extern function                new(string name = "cfg_coeffs_gen");
  extern function cfg_coeffs_gen  get_config(uvm_component c);
endclass: cfg_coeffs_gen

//----
function cfg_coeffs_gen::new(string name = "cfg_coeffs_gen");
  super.new(name);
endfunction: new

//----
function cfg_coeffs_gen cfg_coeffs_gen::get_config(uvm_component c);
  cfg_coeffs_gen t;
  if (!uvm_config_db #(cfg_coeffs_gen)::get(c, "", "cfg_coeffs_gen", t) ) begin
    `uvm_fatal(get_type_name(), UVC_COEFFS_RPTS_CFG_GETTING_FAILURE)
  end
  return t;
endfunction: get_config
