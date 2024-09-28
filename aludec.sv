`include "consts.sv"

module aludec
(
	input[2:0] func3,
	output[2:0] alu_control
);
	
	always_comb
	begin
		case (func3)
			`FUNC3_ADD: alu_control	= `ALU_ADD;
			`FUNC3_OR:	alu_control	= `ALU_OR;
			`FUNC3_AND:	alu_control	= `ALU_AND;
			default:		alu_control	= 3'bxxx;
		endcase
	end
endmodule