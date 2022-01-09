`ifndef PKG_CLK_GEN_SV
    `define PKG_CLK_GEN_SV

    package pkg_clk_gen;
        import   uvm_pkg::*;
        `include "uvm_macros.svh"

        `include "globals_clk_gen.svh"
        `include "cfg_clk_gen.sv"
        `include "sqi_clk_gen.sv"
        `include "sqr_clk_gen.sv"
        `include "drv_clk_gen.sv"
        `include "ag_clk_gen.sv"
    endpackage

`endif
