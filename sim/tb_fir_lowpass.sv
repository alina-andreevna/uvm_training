// Testbench foe FIR_lowpass with using UVM

import uvm_pkg::*;

`define CLK100 10ns

`define INPUT_WORD_SIZE 10
`define OUTPUT_WORD_SIZE 10

module tb_fir_lowpass();

	logic clk;
	logic reset;

	fir_lowpass DUT(
		.clk_in(test_env.clk),
		.rst_in(test_env.reset),
		.data_in(test_env.data_out),
		.data_out(test_env.data_in)
		);

	test_env ENV (.*);


  	initial begin
  		// uvm_config_db#()::set(this, "", "", );
  		run_test("simple_est");
  	end

endmodule : tb_fir_lowpass
