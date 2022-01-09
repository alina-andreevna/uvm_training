class cfg_data_gen extends uvm_object;
  `uvm_object_utils(cfg_data_gen)
  //----
  uvm_active_passive_enum active = UVM_ACTIVE;

  //---- verbosity levels and reports
  uvm_verbosity vrb_lvl_drv = UVM_HIGH; //UVM_LOW UVM_HIGH
  uvm_verbosity vrb_lvl_sqr = UVM_HIGH; //UVM_LOW UVM_HIGH

  //----
  mode_t mode = SLV;

  //----
  extern function              new(string name = "cfg_data_gen");
  extern function cfg_data_gen  get_config(uvm_component c);
endclass: cfg_data_gen

//----
function cfg_data_gen::new(string name = "cfg_data_gen");
  super.new(name);
endfunction: new

//----
function cfg_data_gen cfg_data_gen::get_config(uvm_component c);
  cfg_data_gen t;
  if (!uvm_config_db #(cfg_data_gen)::get(c, "", "cfg_data_gen", t) ) begin
    `uvm_fatal(get_type_name(), DATA_GEN_RPTS_CFG_GETTING_FAILURE)
  end
  return t;
endfunction: get_config
