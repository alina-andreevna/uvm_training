class ag_data_gen #(
  parameter string ID = ""
) extends uvm_agent;
  //----
  `uvm_component_param_utils(ag_data_gen #(ID))
  //----
  cfg_data_gen                       m_cfg;
  drv_data_gen  #(ID)                m_drv;
  sqr_data_gen                       m_sqr;

  uvm_analysis_port #(sqi_data_gen)  o_ap;

  //----
  extern function       new(string name = "ag_data_gen", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern function void  connect_phase(uvm_phase phase);
endclass: ag_data_gen

//----
function ag_data_gen::new(string name = "ag_data_gen", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

//----
function void ag_data_gen::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  //----
  super.build_phase(phase);
  //----
  if (!uvm_config_db #(cfg_data_gen)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(ID, DATA_GEN_RPTS_CFG_GETTING_FAILURE)
  //----
  if(m_cfg.active == UVM_ACTIVE) begin
    m_sqr = sqr_data_gen::type_id::create("m_sqr", this);
    m_drv = drv_data_gen#(ID)::type_id::create("m_drv", this);
  end
endfunction: build_phase

//----
function void ag_data_gen::connect_phase(uvm_phase phase);
  `uvm_info(get_name(), "connect phase", UVM_FULL);
  super.connect_phase(phase);
  //----
  if(m_cfg.active == UVM_ACTIVE)
    m_drv.seq_item_port.connect(m_sqr.seq_item_export);
endfunction: connect_phase
