module snakeCtrl (
	input clk,
	input updateClk,
	input reset,
	input btnUp,
	input btnDown,
	input btnLeft,
	input btnRight,
	input [3:0] foodX,
	input [3:0] foodY,
	output reg [7:0] MATRIX_ROW,
	output reg [15:0] MATRIX_COL
);

wire [3:0] x, y;
wire [7:0] pos = {x, y};
wire [7:0] tailPos;
wire [7:0] foodPos = {foodX, foodY};

reg req;

reg lock;

initial begin
	lock <= 1;
end

snakeMove move (
	.clk(updateClk),
	.reset(reset),
	.lock(lock),
	.btnUp(btnUp),
	.btnDown(btnDown),
	.btnLeft(btnLeft),
	.btnRight(btnRight),
	.x(x),
	.y(y)
);

fifo body (
	.aclr(reset),
	.data(pos),
	.wrreq(req),
	.q(tailPos),
	.rdreq(req)
);

display disp (
	.clk(clk),
	.pos(pos),
	.tailPos(tailPos),
	.MATRIX_ROW(MATRIX_ROW),
	.MATRIX_COL(MATRIX_COL)
);

always @(pos) begin 
	req = 1;
	req = 0;
end

endmodule