`include "consts.sv"

module alu
	#(parameter N = 32)
(
		input[2:0] func3,
		input[N-1:0] operand_a,
		input[N-1:0] operand_b,
		output[N-1:0] result
	);
	
	always_comb
	begin
		case (func3)
			`FUNC3_ADD: result = operand_a + operand_b;
			`FUNC3_OR: result = operand_a | operand_b;
			default: result = 0;
		endcase
	end
endmodule