`ifndef PKG_UVC_COEFFS_SV
`define PKG_UVC_COEFFS_SV

  package pkg_coeffs_gen;
    import   uvm_pkg::*;
    `include "uvm_macros.svh"
    //----
    `include "globals_coeffs_gen.svh"
    `include "cfg_coeffs_gen.sv"
    `include "sqi_coeffs_gen.sv"
    `include "sqr_coeffs_gen.sv"
    `include "drv_coeffs_gen.sv"
    `include "ag_coeffs_gen.sv"
  endpackage

`endif
