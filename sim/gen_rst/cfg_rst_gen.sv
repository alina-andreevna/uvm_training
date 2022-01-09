class cfg_rst_gen extends uvm_object;
  `uvm_object_utils(cfg_rst_gen)
  //----
  uvm_active_passive_enum active = UVM_ACTIVE;

  //---- verbosity levels and reports
  uvm_verbosity vrb_lvl_drv = UVM_HIGH; //UVM_LOW UVM_HIGH
  uvm_verbosity vrb_lvl_sqr = UVM_HIGH; //UVM_LOW UVM_HIGH

  //----
  rst_level_t dflt_rst_lvl = PASSIVE;

  //----
  extern function              new(string name = "cfg_rst_gen");
  extern function cfg_rst_gen  get_config(uvm_component c);
endclass: cfg_rst_gen

//----
function cfg_rst_gen::new(string name = "cfg_rst_gen");
  super.new(name);
endfunction: new

//----
function cfg_rst_gen cfg_rst_gen::get_config(uvm_component c);
  cfg_rst_gen t;
  if (!uvm_config_db #(cfg_rst_gen)::get(c, "", "cfg_rst_gen", t) ) begin
    `uvm_fatal(get_type_name(), RST_GEN_RPTS_CFG_GETTING_FAILURE)
  end
  return t;
endfunction: get_config
