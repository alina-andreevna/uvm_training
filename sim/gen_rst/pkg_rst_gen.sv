`ifndef PKG_RST_GEN_SV
`define PKG_RST_GEN_SV

package pkg_rst_gen;
  import   uvm_pkg::*;
  `include "uvm_macros.svh"
  //----
  `include "globals_rst_gen.svh"
  `include "cfg_rst_gen.sv"
  `include "sqi_rst_gen.sv"
  `include "sqr_rst_gen.sv"
  `include "drv_rst_gen.sv"
  `include "ag_rst_gen.sv"

endpackage

`endif
