`ifndef PKG_DATA_GEN_SV
    `define PKG_DATA_GEN_SV

    `define INPUT_WIDTH 10
    `define OUTPUT_WIDTH 12

    package pkg_data_gen;
      import   uvm_pkg::*;
      `include "uvm_macros.svh"
      //----
      `include "globals_data_gen.svh"
      `include "cfg_data_gen.sv"
      `include "sqi_data_gen.sv"
      `include "sqr_data_gen.sv"
      `include "drv_data_gen.sv"
      `include "ag_data_gen.sv"

    endpackage

`endif
