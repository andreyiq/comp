`include "consts.sv"

module mem
	#(parameter N = 8)
(input[N-1:0] raddr, output[N-1:0] out);

	logic[7:0] data [0:N-1] = '{8,7,6,5,4,3,2,1};
	
	assign out = data[raddr];
endmodule