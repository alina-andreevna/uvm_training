// Top testbench for FIR_lowpass with using UVM

`include "fir_param_pkg.svh"

module tb_top_fir_lowpass();

    import uvm_pkg::*;
    import tb_pkg::*;

    fir_if fir_if();
	fir_lowpass DUT(fit_if.fir);


    initial begin
        string test_name;

        global_fir_if = fir_if;

        run_test();
    end

endmodule : tb_top_fir_lowpass
