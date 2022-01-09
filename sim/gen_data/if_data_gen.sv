`define INPUT_WIDTH 10
`define OUTPUT_WIDTH 12

interface if_data_gen();

    bit [`INPUT_WIDTH-1 : 0] data_in;
    bit [`OUTPUT_WIDTH-1 : 0] data_out;

    modport fir (
        input data_in,
        output data_out);

    modport tester(
        output data_in,
        input data_out);
     
endinterface : if_data_gen