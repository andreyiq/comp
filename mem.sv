`include "consts.sv"

module mem
(input[31:0] a, output[31:0] rd);
	logic[31:0] RAM [63:0];
	
	initial
		$readmemh("riscvtest.hex", RAM);

	assign rd = RAM[a[31:2]]; // word aligned
endmodule