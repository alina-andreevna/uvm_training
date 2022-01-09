class cfg_clk_gen extends uvm_object;
  `uvm_object_utils(cfg_clk_gen)

  uvm_active_passive_enum active = UVM_ACTIVE;

  uvm_verbosity vrb_lvl_drv = UVM_HIGH; 
  uvm_verbosity vrb_lvl_sqr = UVM_HIGH; 

  extern function              new(string name = "cfg_clk_gen");
  extern function cfg_clk_gen  get_config(uvm_component c);
endclass: cfg_clk_gen

function cfg_clk_gen::new(string name = "cfg_clk_gen");
  super.new(name);
endfunction: new

function cfg_clk_gen cfg_clk_gen::get_config(uvm_component c);
  cfg_clk_gen t;

  if (!uvm_config_db #(cfg_clk_gen)::get(c, "", "cfg_clk_gen", t) ) begin
    `uvm_fatal(get_type_name(), CLK_GEN_RPTS_CFG_GETTING_FAILURE)
  end
  
  return t;
endfunction: get_config
