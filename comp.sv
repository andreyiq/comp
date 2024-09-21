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
	
	logic[31:0] out;
	mem(pc, out);
	
	initial
		digs = 'b001;
	
	logic[3:0] dig_out;
	
	always @(posedge clk_fast)
	begin
		if (digs == 'b100)
			digs = 'b001;
		else
			digs = digs << 1;
		case (digs)
			'b001: dig_out = out[3:0];
			'b010: dig_out = out[7:4];
			'b100: dig_out = out[11:8];
		endcase
	end
	sevenseg(dig_out, segs);
	
	/*
	parameter INC_COUNT = 32'd25000000;
	typedef enum logic[1:0] { STATE_A, STATE_COMMAND, STATE_B, STATE_EQUAL} statetype;
	logic[3:0] a, b;
	logic[4:0] command = `F_ADD;
	statetype state = STATE_A;

	logic[3:0] value;
	logic[3:0] result;
	logic on_click_inc, on_click_state;

	button(sys_clk, buttons[0], on_click_state);

	always @(posedge on_click_state)
		case (state)
			STATE_A: 		state <= STATE_COMMAND;
			STATE_COMMAND: state <= STATE_B;
			STATE_B:			state <= STATE_EQUAL;
			STATE_EQUAL:	state <= STATE_A;
			default:			state <= STATE_A;
		endcase

	button(sys_clk, buttons[1], on_click_inc);

	always @(posedge on_click_inc)
		case (state)
			STATE_A:
				if (a > 4'd8)
					a <= 4'd0;
				else
					a <= a + 4'd1;

			STATE_COMMAND:
				case (command)
					`F_ADD: 	command <= `F_SUB;
					default:	command <= `F_ADD;
				endcase

			STATE_B:
				if (b > 4'd8)
					b <= 4'd0;
				else
					b <= b + 4'd1;
		endcase

	alu(command, a, b, result);

	always
		case (state)
			STATE_A:
				value <= a;

			STATE_COMMAND:
				value <= { 3'd0, command };

			STATE_B:
				value <= b;

			STATE_EQUAL:
				value <= result;
		endcase

	sevenseg(value, segs);
	assign digs = 'b001;
	*/
endmodule