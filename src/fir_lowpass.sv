import pkg_fir::*;

module fir_lowpass #(parameter int I_WIDTH = 0,
					 parameter int O_WIDTH = 0)
	(input logic clk,
	input logic rst,
	input logic [I_WIDTH-1:0] data_in,
	input coeffs_t coeffs,
	output logic [O_WIDTH-1:0] data_out);

	reg [I_WIDTH-1 : 0] x [1:fir_order];
	reg [I_WIDTH-1 : 0] data_in_reg = 0;

	integer k = 0;

	assign data_out = coeffs[0] * data_in_reg + coeffs[1] * x[1] + coeffs[2] * x[2] + coeffs[3] * x[3] + 
					coeffs[4] * x[4] + coeffs[5] * x[5] + coeffs[6] * x[6] + coeffs[7] * x[7] + coeffs[8] * x[8];

	always_ff @(posedge clk) begin : proc_x
		if(rst) begin
			for (k=1; k<=fir_order; k++) x[k] <= 0;
			data_in_reg <= 0;
		end else begin
			data_in_reg <= data_in;
			x[1] <= data_in_reg;
			for (k=2; k<=fir_order; k++) x[k] <= x[k-1];
		end
	end

endmodule : fir_lowpass