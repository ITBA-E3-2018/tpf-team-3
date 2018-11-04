`timescale 10ns / 10ns
module clock_gen(clk);

parameter PERIOD = 2;

output reg clk;
	 
always
	begin: MATI
		clk <= 1'b0;
		#(PERIOD/2);
		clk <= 1'b1;
		#(PERIOD/2);
	end
endmodule