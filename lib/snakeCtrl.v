module snakeCtrl (
	input clk,
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
reg lock = 0;

wire updateClk;
wire displayClk;

prescaler prescaler1 (
	.clkIn(clk),
	.clkOut(updateClk)
);
defparam prescaler1.DIV = 2;

prescaler prescaler2 (
	.clkIn(clk),
	.clkOut(displayClk)
);
defparam prescaler2.DIV = 1024;

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
	.clk(displayClk),
	.pos(pos),
	.tailPos(tailPos),
	.MATRIX_ROW(MATRIX_ROW),
	.MATRIX_COL(MATRIX_COL)
);

pulseGen pulse (
	.clk(clk),
	.trigger(pos),
	.pulseOut(req)
);

initial begin
	pos <= 8'b00000000;
	@(posedge clk) pos <= 8b'00000001;
	@(posedge clk) pos <= 8b'00000010;
	@(posedge clk) lock <= 1;
end

endmodule