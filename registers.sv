module registers
(input[4:0] a, output[31:0] rd);
	logic[31:0] REGISTERS [31:0];
	assign rd = REGISTERS[a];
endmodule