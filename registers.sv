module registers
(input clk, input write_enabled, input[4:0] rd_addr, input[4:0] rs1_addr, input[31:0] rd_data, output[31:0] rs1_data);
	logic[31:0] REGISTERS [31:0];
	assign rs1_data = REGISTERS[rs1_addr];
	
	always_ff @(posedge clk)
		if (write_enabled)
			REGISTERS[rd_addr] <= rd_data;
endmodule