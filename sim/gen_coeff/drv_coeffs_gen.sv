class drv_coeffs_gen #(
  parameter string ID = ""
) extends uvm_driver #(sqi_coeffs_gen);
  //----
  `uvm_component_param_utils(drv_coeffs_gen #(ID))
  //---- standard variables
  cfg_coeffs_gen     m_cfg;
  sqi_coeffs_gen     req;
  uvm_verbosity     local_vrb_lvl = UVM_LOW;
  time              cur_time;
  logic             fl_new_sqi;
  coeffs_t          coeffs;
  virtual if_coeffs_gen vif;
  //---- user defined variables
  //----
  extern function       new(string name = "drv_coeffs_gen", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern function void  connect_phase(uvm_phase phase);
  extern task           run_phase(uvm_phase phase);
  extern task           set_dflt_if();
  extern task           start_trn();
  extern task           finish_trn();
  //----
  extern task           get_new_sqi();
  extern task           drive();
endclass: drv_coeffs_gen

//----
function drv_coeffs_gen::new(string name = "drv_coeffs_gen", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

//----
function void drv_coeffs_gen::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  super.build_phase(phase);
  if (!uvm_config_db #(cfg_coeffs_gen)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(ID, UVC_COEFFS_RPTS_CFG_GETTING_FAILURE)
  local_vrb_lvl = m_cfg.vrb_lvl_drv;
endfunction: build_phase

//----
function void drv_coeffs_gen::connect_phase(uvm_phase phase);
  `uvm_info(get_name(), "connect phase", UVM_FULL);
  super.connect_phase(phase);
  if (!uvm_config_db #(virtual if_coeffs_gen)::get(this, "", "vif", vif))
    `uvm_fatal(ID, UVC_COEFFS_RPTS_IF_GETTING_FAILURE)
endfunction: connect_phase
//----
task drv_coeffs_gen::run_phase(uvm_phase phase);
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
task drv_coeffs_gen::set_dflt_if();
  vif.coeffs = DEFAULT_COEFFS;
endtask: set_dflt_if

//---- get new sqi
task drv_coeffs_gen::get_new_sqi();
  seq_item_port.get_next_item(req);
  start_trn();
  //---- copy parameters into internal variables
  coeffs = req.coeffs;
  //----
  finish_trn();
  seq_item_port.item_done();
endtask: get_new_sqi


//---- start a new transaction
task drv_coeffs_gen::start_trn();
  cur_time = $time;
  accept_tr(req, cur_time);
  void'(
    begin_tr(
      req, {ID, "_drv_stream"}, ID,
      {"fir coeffs generator settings"},
      cur_time
    )
  );
endtask

//---- finish an already started transtation
task drv_coeffs_gen::finish_trn();
  void'(end_tr(req, $time));
  `uvm_info(ID, {"The item for fir input is done:\n", req.convert2string(), "\n\n"}, local_vrb_lvl)
endtask

//---- drive lines
task drv_coeffs_gen::drive();
  vif.coeffs = coeffs;
endtask: drive
