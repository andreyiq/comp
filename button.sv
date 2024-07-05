module button(input sys_clk, input btn, output on_click);
	parameter CLICK_COUNT = 32'd2500000;
	parameter INC_COUNT = 32'd25000000;
	
	logic[31:0] count;
	
	always@(posedge sys_clk)
		if (btn)
			count = 32'd0;
		else begin
			count = count + 32'd1;
			on_click = count == CLICK_COUNT || count == INC_COUNT;
			if (on_click)
				count = CLICK_COUNT;
		end
endmodule