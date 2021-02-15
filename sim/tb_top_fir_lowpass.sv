// Top testbench for FIR_lowpass with using UVM

`include "fir_param_pkg.svh"

module tb_top_fir_lowpass();

    import uvm_pkg::*;
    import tb_pkg::*;

    fir_if vif();
    fir_lowpass DUT(vif.fir);


    initial begin
        string test_name;

        global_fir_if = vif;

        run_test();
    end

         // generate clock and reset
     
     initial begin
        vif.clk_in = 0;
        forever begin
            #(`CLK_PERIOD)  vif.clk_in = ~ vif.clk_in;
        end
     end

     initial begin
         vif.rst_in = 1;
        #(`CLK_PERIOD * 5)    vif.rst_in = 0;

     end

endmodule : tb_top_fir_lowpass
