class drv_clk_gen #(
  parameter string ID = ""
) extends uvm_driver #(sqi_clk_gen);

  `uvm_component_param_utils(drv_clk_gen #(ID))

  cfg_clk_gen     m_cfg;
  sqi_clk_gen     req;
  uvm_verbosity   local_vrb_lvl = UVM_LOW;
  logic           fl_new_sqi;
  time            cur_time;
  time            half_of_period;

  virtual if_clk_gen vif;

  extern function       new(string name = "drv_clk_gen", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern function void  connect_phase(uvm_phase phase);
  extern task           run_phase(uvm_phase phase);
  extern task           set_dflt_if();
  extern task           start_trn();
  extern task           finish_trn();

  extern task           get_new_sqi();
  extern task           drive();
endclass: drv_clk_gen

function drv_clk_gen::new(string name = "drv_clk_gen", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

function void drv_clk_gen::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  super.build_phase(phase);
  if (!uvm_config_db #(cfg_clk_gen)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(ID, CLK_GEN_RPTS_CFG_GETTING_FAILURE)
  local_vrb_lvl = m_cfg.vrb_lvl_drv;
endfunction: build_phase

function void drv_clk_gen::connect_phase(uvm_phase phase);
  `uvm_info(get_name(), "connect phase", UVM_FULL);
  super.connect_phase(phase);
  if (!uvm_config_db #(virtual if_clk_gen)::get(this, "", "vif", vif))
    `uvm_fatal(ID, CLK_GEN_RPTS_IF_GETTING_FAILURE)
endfunction: connect_phase

task drv_clk_gen::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "run phase", UVM_FULL)
  set_dflt_if();
  get_new_sqi();
  fl_new_sqi = '0;

  forever begin
    fork
      get_new_sqi();
      drive();
    join
    fl_new_sqi = '0;

  end
endtask: run_phase

task drv_clk_gen::set_dflt_if();
  vif.r_clk = DEFAULT_OUPUT_LVL;
endtask: set_dflt_if

task drv_clk_gen::get_new_sqi();
  seq_item_port.get_next_item(req);
  start_trn();

  half_of_period = req.period/2;
  fl_new_sqi = '1;

  finish_trn();
  seq_item_port.item_done();
endtask: get_new_sqi

task drv_clk_gen::start_trn();
  cur_time = $time;
  accept_tr(req, cur_time);
  void'(
    begin_tr(
      req, {ID, "_drv_stream"}, ID,
      {"clk generator settings"},
      cur_time
    )
  );
endtask

task drv_clk_gen::finish_trn();
  void'(end_tr(req, $time));
  `uvm_info(ID, {"The item is done:\n", req.convert2string(), "\n\n"}, local_vrb_lvl)
endtask

task drv_clk_gen::drive();
  do begin
    vif.r_clk = '1;
    #(half_of_period);
    vif.r_clk = '0;
    #(half_of_period);
  end
  while (!fl_new_sqi);
endtask: drive
