module clk_setup (
	input clk,
	output displayClk,
	output updateClk
);

prescaler #(2) prescaler1 (
	.clkIn(clk),
	.clkOut(updateClk)
);

prescaler #(1024) prescaler2 (
	.clkIn(clk),
	.clkOut(displayClk)
);

endmodule