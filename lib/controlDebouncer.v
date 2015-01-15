module controlDebouncer (
	input clk,
	input [3:0] buttonsIn,
	output [3:0] buttonsOut
);

debouncer db0 (
	.clk(clk),
	.btn(buttonsIn[0]),
	.on(buttonsOut[0])
);

debouncer db1 (
	.clk(clk),
	.btn(buttonsIn[1]),
	.on(buttonsOut[1])
);

debouncer db2 (
	.clk(clk),
	.btn(buttonsIn[2]),
	.on(buttonsOut[2])
);

debouncer db3 (
	.clk(clk),
	.btn(buttonsIn[3]),
	.on(buttonsOut[3])
);

endmodule