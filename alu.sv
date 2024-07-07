`include "consts.sv"

module alu
	#(parameter N = 32)
(
		input[4:0] opcode,
		input[N-1:0] operand_a,
		input[N-1:0] operand_b,
		output[N-1:0] result
	);
	
	always_comb
	begin
		case (opcode)
			`F_ADD: result = operand_a + operand_b;
			default: result = 0;
		endcase
	end
	// assign res = a + b;
endmodule