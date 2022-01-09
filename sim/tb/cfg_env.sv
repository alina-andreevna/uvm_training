class cfg_env extends uvm_object;
  `uvm_object_utils(cfg_env)
  //---- parameters
  // uvm_active_passive_enum en_scbrd            = UVM_PASSIVE;
  //---- verbosity levels
  uvm_verbosity vrb_lvl_sqr                   = UVM_HIGH; //UVM_LOW UVM_HIGH
  //---- scoreboard settings
  // bit scbrd_en_rpt_in_hoarder   = '0;
  // bit scbrd_en_rpt_in_analyzer  = '0;
  //----
  extern function new(string name = "cfg_env");
  extern function cfg_env  get_config(uvm_component c);
endclass: cfg_env

//----
function cfg_env::new(string name = "cfg_env");
  super.new(name);
endfunction: new

//----
function cfg_env cfg_env::get_config(uvm_component c);
  cfg_env t;
  if (!uvm_config_db #(cfg_env)::get(c, "", "cfg_env", t) ) begin
    `uvm_fatal(get_type_name(), TB_RPTS_CFG_GETTING_FAILURE)
  end
  return t;
endfunction: get_config
