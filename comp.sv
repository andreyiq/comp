`include "consts.sv"

module comp(input sys_clk, input sys_rst, input button, output[7:0] segs, output wire[2:0] digs);
	
	parameter CLICK_COUNT = 32'd50000000;
	logic[31:0] clk_count;
	logic clk_slow;
	logic clk_fast;
	
	always @(posedge sys_clk)
	begin
		clk_count = clk_count + 1;
		if (clk_count == CLICK_COUNT)
		begin
			clk_slow = 1;
			clk_count = 0;
		end else
		begin
			clk_slow = 0;
		end
		
		if (clk_count % 32'd100000 == 0)
		begin
			clk_fast = 1;
		end else
		begin
			clk_fast = 0;
		end
	end

	
	parameter MEM_SIZE = 64;
		
	logic[31:0] pc;
	
	always @(posedge clk_slow)
	begin
		pc = pc + 4;
		if (pc > MEM_SIZE - 1)
			pc = 0;
	end
	
	logic[31:0] command;
	logic[31:0] result;
	mem(pc, command);
	
	logic[31:0] imm;
	logic[31:0] rs1_data;
	logic[31:0] rs2_data;
	logic[4:0] rs2_addr;
	logic[4:0] rs1_addr;
	logic[2:0] func3;
	logic[4:0] rd_addr;
	logic[6:0] opcode;
	
	extend(command[31:20], imm);
	assign rs2_addr = command[24:20];
	assign rs1_addr = command[19:15];
	assign func3 = command[14:12];
	assign rd_addr = command[11:7];
	assign opcode = command[6:0];
	
	logic [31:0] src_a;
	logic [31:0] src_b;

	registers(clk_slow, 1, rd_addr, rs1_addr, rs2_addr, result, rs1_data, rs2_data);
	
	assign src_a = rs1_data;
	
	always_comb
		if (opcode == `OPCODE_I)
			src_b = imm;
		else
			src_b = rs2_data;
	
	logic [2:0] alu_control;
	aludec(func3, alu_control);
	alu(alu_control, src_a, src_b, result);

	sevenseg(clk_fast, {src_a[7:0], rs2_data[7:0], result[7:0]}, segs, digs);
endmodule