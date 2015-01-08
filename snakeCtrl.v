module snakeCtrl (
	input clk,
	input reset,
	input btnUp,
	input btnDown,
	input btnLeft,
	input btnRight,
	input [3:0] foodX,
	input [3:0] foodY
);

reg [3:0] x, y;
wire [7:0] pos = {x, y};

reg [7:0] foodPos = {foodX, foodY};

reg [15:0] pixelRow [7:0];

integer i;
initial
	for(i = 0; i < 8; i = i+1)
		pixelRow[i] <= 16'hFFFF;
		
snakeMove move (
	.clk(clk),
	.reset(reset),
	.btnUp(btnUp),
	.btnDown(btnDown),
	.btnLeft(btnLeft),
	.btnRight(btnRight),
	.x(x),
	.y(y)
);

fifo body (
	.aclr(reset),
	.data(pos)
);


endmodule