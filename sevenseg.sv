module sevenseg(input[3:0] data, output[7:0] segments);
	always_comb
		case (data)
			0: 		segments = 8'b11000000;
			1: 		segments = 8'b11111001;
			2: 		segments = 8'b10100100;
			3: 		segments = 8'b10110000;
			4: 		segments = 8'b10011001;
			5: 		segments = 8'b10010010;
			6: 		segments = 8'b10000010;
			7: 		segments = 8'b11111000;
			8: 		segments = 8'b10000000;
			9:			segments = 8'b10010000;
			10:		segments = 8'b10001000;
			11:		segments = 8'b10000011;
			12:		segments = 8'b11000110;
			13:		segments = 8'b10100001;
			14:		segments = 8'b10000110;
			15:		segments = 8'b10001110;
			default:	segments = 8'b01111111;
		endcase
endmodule