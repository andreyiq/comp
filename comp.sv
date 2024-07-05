module comp(input sys_clk, input[1:0] buttons, output[7:0] segs, output wire[2:0] digs);
	parameter CLICK_COUNT = 32'd2500000;
	parameter INC_COUNT = 32'd25000000;
	
	logic[3:0] value;
	logic[31:0] count;
	logic on_click;
	
	button(sys_clk, buttons[1], on_click);
	
	always@(posedge on_click)
		if (value > 4'd8)
			value <= 4'd0;
		else
			value <= value + 4'd1;

	sevenseg(value, segs);
	assign digs = 'b001;
endmodule