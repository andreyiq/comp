`include "consts.sv"

module alu
	#(parameter N = 32)
(
		input[2:0] alu_control,
		input[N-1:0] operand_a, operand_b,
		output[N-1:0] result
	);
	
	always_comb
	begin
		case (alu_control)
			`ALU_ADD:	result = operand_a + operand_b;
			`ALU_OR:		result = operand_a | operand_b;
			`ALU_AND:	result = operand_a & operand_b;
			default:		result = 0;
		endcase
	end
endmodule