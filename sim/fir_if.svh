`include "fir_param_pkg.svh"

interface fir_if ;

    bit clk_in;
    bit rst_in;

    reg [`INPUT_WORD_SIZE-1 : 0] data_in;
    reg [`OUTPUT_WORD_SIZE-1 : 0] data_out;

    modport fir (
        input clk_in,
        input rst_in,
        input data_in,
        output data_out);

    modport tester(
        output clk_in,
        output rst_in,
        output data_in,
        input data_out);
     
endinterface : fir_if