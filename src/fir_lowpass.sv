// FIR_lowpass

`include "../sim/fir_param_pkg.svh"

 module fir_lowpass (fir_if.fir f);

	localparam order = 8;

	localparam b0 = 8'd7;
	localparam b1 = 8'd17;
	localparam b2 = 8'd32;
	localparam b3 = 8'd46;
	localparam b4 = 8'd52;
	localparam b5 = 8'd46;
	localparam b6 = 8'd32;
	localparam b7 = 8'd17;
	localparam b8 = 8'd7;

	reg [`INPUT_WORD_SIZE-1 : 0] x[1 : order];
	integer k;

	assign f.data_out = b0 * f.data_in + b1 * x[1] + b2 * x[2] + b3 * x[3] + 
						b4 * x[4] + b5 * x[5] + b6 * x[6] + b7 * x[7] + b8 * x[8];

	always_ff @(posedge f.clk_in) begin : proc_x1
		if(f.rst_in) begin
			for (k=1; k<=order; k++) x[k] <= 0;
		end else begin
			x[1] <= f.data_in;
			for (k=2; k<=order; k++) x[k] <= x[k-1];
		end
	end

endmodule : fir_lowpass