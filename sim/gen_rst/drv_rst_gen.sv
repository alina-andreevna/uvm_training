class drv_rst_gen #(
  parameter string ID = ""
) extends uvm_driver #(sqi_rst_gen);
  //----
  `uvm_component_param_utils(drv_rst_gen #(ID))
  //---- standard variables
  cfg_rst_gen     m_cfg;
  sqi_rst_gen     req;
  uvm_verbosity   local_vrb_lvl = UVM_LOW;
  time            cur_time;
  logic           fl_new_sqi;
  rst_level_t     rst_lvl;

  virtual if_rst_gen vif;
  //---- user defined variables
  //----
  extern function       new(string name = "drv_rst_gen", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern function void  connect_phase(uvm_phase phase);
  extern task           run_phase(uvm_phase phase);
  extern task           set_dflt_if();
  extern task           start_trn();
  extern task           finish_trn();
  //----
  extern task           get_new_sqi();
  extern task           drive();
endclass: drv_rst_gen

//----
function drv_rst_gen::new(string name = "drv_rst_gen", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

//----
function void drv_rst_gen::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  super.build_phase(phase);
  if (!uvm_config_db #(cfg_rst_gen)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(ID, RST_GEN_RPTS_CFG_GETTING_FAILURE)
  local_vrb_lvl = m_cfg.vrb_lvl_drv;
endfunction: build_phase

//----
function void drv_rst_gen::connect_phase(uvm_phase phase);
  `uvm_info(get_name(), "connect phase", UVM_FULL);
  super.connect_phase(phase);
  if (!uvm_config_db #(virtual if_rst_gen)::get(this, "", "vif", vif))
    `uvm_fatal(ID, RST_GEN_RPTS_IF_GETTING_FAILURE)
endfunction: connect_phase

//----
task drv_rst_gen::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "run phase", UVM_FULL)
  set_dflt_if();
  get_new_sqi();
  //----
  forever begin
    fork
      get_new_sqi();
      drive();
    join
    fl_new_sqi = '0;  // stay here for future use
    //----
  end
endtask: run_phase

//---- set default statements
task drv_rst_gen::set_dflt_if();
  vif.r_rst   = (m_cfg.dflt_rst_lvl == ACTIVE) ? '1 : '0;
  vif.r_rst_n = (m_cfg.dflt_rst_lvl == ACTIVE) ? '0 : '1;
endtask: set_dflt_if

//---- get new sqi
task drv_rst_gen::get_new_sqi();
  seq_item_port.get_next_item(req);
  start_trn();
  //---- copy parameters into internal variables
  rst_lvl = req.rst_lvl;
  //----
  finish_trn();
  seq_item_port.item_done();
endtask: get_new_sqi


//---- start a new transaction
task drv_rst_gen::start_trn();
  cur_time = $time;
  accept_tr(req, cur_time);
  void'(
    begin_tr(
      req, {ID, "_drv_stream"}, ID,
      {"reset generator settings"},
      cur_time
    )
  );
endtask

//---- finish an already started transtation
task drv_rst_gen::finish_trn();
  void'(end_tr(req, $time));
  `uvm_info(ID, {"The item is done:\n", req.convert2string(), "\n\n"}, local_vrb_lvl)
  // req.print(); // for debugging
endtask

//---- drive lines
task drv_rst_gen::drive();
  vif.r_rst   = (rst_lvl == ACTIVE) ? '1 : '0;
  vif.r_rst_n = (rst_lvl == ACTIVE) ? '0 : '1;
endtask: drive
