`include "fir_param_pkg.svh"

interface fir_if ;

    bit clk_in;
    bit rst_in;

    wire [`INPUT_WORD_SIZE-1 : 0] data_in;
    wire [`OUTPUT_WORD_SIZE-1 : 0] data_out;

    modport fir (
        input clk_in,
        input rst_in,
        input data_in,
        output data_out);

    modport tester(
        input clk_in,
        input rst_in,
        output data_in,
        input data_out);
     
     // generate clock and reset
     
     initial begin
        clk_in = 0;
        forever begin
            #(`CLK_PERIOD) clk_in = ~clk_in;
        end
     end

     initial begin
        rst_in = 1;
        #(`CLK_PERIOD * 5)   rst_in = 0;

     end
     
endinterface : fir_if