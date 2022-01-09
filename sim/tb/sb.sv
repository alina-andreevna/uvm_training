//------------------------------------------------------------------------------
//
//  *** *** ***
// *   *   *   *
// *   *    *     Quantenna
// *   *     *    Connectivity
// *   *      *   Solutions
// * * *   *   *
//  *** *** ***
//     *
//------------------------------------------------------------------------------
class sb extends uvm_component;
  `uvm_component_utils(sb)
  //----
  uvm_tlm_analysis_fifo  #(sqi_cmd_gen) i_ap_cmd_gen
  //----
  bit en_rpt_in_hoarder;
  bit en_rpt_in_analyzer;
  //----
  cfg_env       m_cfg;
  cfg_cmd_gen   m_cmd_gen;
  sqi_cmd_gen   trn_cmg_gen, trn_golden_model, trn_cmd_gen_cmp;
  sqi_cmd_gen   q_cmd_gen [$], q_golden_model [$];
  uvm_verbosity vrb_lvl;
  string        rpt_str;
  event         e_new_trn;
  //----
  extern function       new         (string name = "sb", uvm_component parent = null);
  extern function void  build_phase (uvm_phase phase);
  extern task           run_phase   (uvm_phase phase);
  extern task           hoarder     ();
  extern task           analyzer    ();
  //----
  import "DPI-C" pure function int calc(input int op, input int a, input int b);
endclass: sb

//----
function sb::new(string name = "sb", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

//----
function void sb::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "build phase", UVM_HIGH)
  i_ap_cmd_gen  = new("i_ap_cmd_gen", this);
  if (!uvm_config_db #(cfg_env)::get(this, "", "m_cfg", m_cfg))
    `uvm_fatal(get_name(), {TB_RPTS_CFG_GETTING_FAILURE, "cfg_env"})
  if (!uvm_config_db #(cfg_cmd_gen)::get(this, "*.m_cmd_gen*", "m_cfg", m_cmd_gen))
    `uvm_fatal(get_name(), {TB_RPTS_CFG_GETTING_FAILURE, "cfg_cmd_gen"})
  vrb_lvl             = m_cfg.vrb_lvl_sb;
  en_rpt_in_hoarder   = m_cfg.sb_en_rpt_in_hoarder;
  en_rpt_in_analyzer  = m_cfg.sb_en_rpt_in_analyzer;
endfunction: build_phase

//----
task sb::run_phase(uvm_phase phase);
  trn  = sqi_cmd_gen::type_id::create("cmd gen trn to cmp");
  //----
  fork
    hoarder();
    analyzer();
  join_none
endtask: run_phase

//----
task sb::hoarder();
  fork
    forever begin
      i_ap_cmd_gen.get(trn_cmg_gen);
      q_cmd_gen.push_front(trn_cmg_gen);
      if (en_rpt_in_hoarder) $display($sformatf("Command generator transaction: %s\n", trn_cmg_gen.convert2string()));
      trn_golden_model.copy(trn_cmg_gen);
      -> e_new_trn;
    end
    forever begin
      @ e_new_trn;
      trn_golden_model.res = calc(trn_golden_model.op, trn_golden_model.a, trn_golden_model.b);
      q_golden_model.push_front(trn_golden_model);
      if (en_rpt_in_hoarder) $display($sformatf("Golden model result: %s\n", trn_golden_model.convert2string()));
    end
  join_none
endtask: hoarder

//----
task sb::analyzer();
  //----
  rpt_str = "\nOn-the-go report\n\n";
  rpt_str = {rpt_str, "Status\t| short report\n"};
  rpt_str = {rpt_str, "--------+-------------"};
  $display(rpt_str);
  //----
  forever begin
    rpt_str = "";
    wait (q_cmd_gen.size() > 0);
    wait (q_golden_model.size() > 0);
    //----
    trn_cmd_gen_cmp = q_cmd_gen.pop_back();
    trn_golden_model_cmp = q_golden_model.pop_back();
    //----
    if (trn_golden_model_cmp.compare(trn_cmd_gen_cmp)) begin
    end
    //----
    if (en_rpt_in_analyzer) $display(rpt_str);
  end
endtask: analyzer