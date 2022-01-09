class sqr_clk_gen extends uvm_sequencer #(sqi_clk_gen);
  `uvm_component_utils(sqr_clk_gen)

  cfg_clk_gen   m_cfg;
  uvm_verbosity local_vrb_lvl = UVM_LOW;

  extern function       new(string name = "sqr_clk_gen", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern task           run_phase(uvm_phase phase);
endclass: sqr_clk_gen

function sqr_clk_gen::new(string name = "sqr_clk_gen", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

function void sqr_clk_gen::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_FULL);
  super.build_phase(phase);
  if (!uvm_config_db #(cfg_clk_gen)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(get_name(), CLK_GEN_RPTS_CFG_GETTING_FAILURE)
  local_vrb_lvl = m_cfg.vrb_lvl_sqr;
endfunction: build_phase

task sqr_clk_gen::run_phase(uvm_phase phase);
endtask: run_phase
