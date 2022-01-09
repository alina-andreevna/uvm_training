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
class vsqr extends uvm_sequencer;
  `uvm_component_utils(vsqr)
  //----
  sqr_rst_gen     m_sqr_rst_gen0;
  sqr_clk_gen     m_sqr_clk_gen0;
  sqr_data_gen    m_sqr_data_gen0;
  sqr_coeffs_gen    m_sqr_coeffs_gen0;
  //----
  extern function new(string name = "vsqr", uvm_component parent = null);
endclass: vsqr

//----
function vsqr::new(string name = "vsqr", uvm_component parent = null);
  super.new(name, parent);
endfunction: new
