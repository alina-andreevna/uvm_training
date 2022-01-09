module tb;
  //---- uvm components
  import    uvm_pkg::*;
  `include  "uvm_macros.svh"

  import    pkg_fir::*;
  import    pkg_rst_gen::*;
  import    pkg_clk_gen::*;
  import    pkg_data_gen::*;
  import    pkg_coeffs_gen::*;

  `include  "globals.svh"
  `include  "cfg_env.sv"
  // `include  "sb.sv"
  `include  "vsqr.sv"
  `include  "env.sv"

  `include  "../tests/inc_list_tests.sv"

  wire  clk;
  wire  rst;

  wire [INPUT_DATA_WIDTH-1:0] data_in;
  wire [OUTPUT_DATA_WIDTH-1:0] data_out;

  wire coeffs_t coeffs;

  //---- interfaces
  if_clk_gen    if_clk_gen();
  if_rst_gen    if_rst_gen();
  if_data_gen   if_data_gen(); 
  if_coeffs_gen if_coeffs_gen(); 

//------------------------------------------------------------------------------
//---- database
//------------------------------------------------------------------------------
  initial begin
    uvm_config_db #(virtual if_rst_gen)::set(null, "*m_env.m_rst_gen*", "vif", if_rst_gen);
    uvm_config_db #(virtual if_clk_gen)::set(null, "*m_env.m_clk_gen0*", "vif", if_clk_gen);
    uvm_config_db #(virtual if_data_gen)::set(null, "*m_env.m_data_gen0*", "vif", if_data_gen);
    uvm_config_db #(virtual if_coeffs_gen)::set(null, "*m_env.m_coeffs_gen0*", "vif", if_coeffs_gen);
    run_test();
    $finish;
  end

//------------------------------------------------------------------------------
//---- commutation
//------------------------------------------------------------------------------
  //----
  assign clk = if_clk_gen.clk;
  assign rst = if_rst_gen.rst;

  assign data_in  = if_data_gen.data_in;
  assign data_out = if_data_gen.data_out;
  assign coeffs   = if_coeffs_gen.coeffs;

//------------------------------------------------------------------------------
//---- dut
//------------------------------------------------------------------------------
  fir_lowpass   #(
    .I_WIDTH(INPUT_DATA_WIDTH),
    .O_WIDTH(OUTPUT_DATA_WIDTH))
  dut ( 
    .clk        (clk),
    .rst        (rst),
    .data_in    (data_in),
    .coeffs     (coeffs),
    .data_out   (data_out));
endmodule
