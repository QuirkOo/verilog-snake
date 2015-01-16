module snakeCtrl (
	input clk,
	input start,
	input btnUp,
	input btnDown,
	input btnLeft,
	input btnRight,
	output [7:0] MATRIX_ROW,
	output [15:0] MATRIX_COL
);

wire lock;
assign lock = ~start;

wire [8*16-1:0] pixelReg;
wire [3:0] x, y;
wire [7:0] pos = {x, y};
wire [7:0] tailPos;

wire wrreq;
wire rdreq;
assign rdreq = wrreq;



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
	.clock(clk),
	.aclr(reset),
	.data(pos),
	.wrreq(wrreq),
	.q(tailPos),
	.rdreq(rdreq)
);

display disp (
	.clk(displayClk),
	.pixelReg(pixelReg),
	.MATRIX_ROW(MATRIX_ROW),
	.MATRIX_COL(MATRIX_COL)
);

pulseGen pulse1 (
	.clk(clk),
	.trigger(pos),
	.pulseOut(wrreq)
);

pulseGen pulse2 (
	.clk(clk),
	.trigger(tailPos),
	.pulseOut(genreq)
);

wire [3:0] foodX;
wire [3:0] foodY;
wire [7:0] foodPos = {foodX, foodY};
wire foodReq;

randomizer food (
	.clk(updateClk),
	.x(foodX),
	.y(foodY),
	.req(foodReq)
);

pixelGen pixel (
	.genreq(updateClk),
	.pos(pos),
	.tailPos(tailPos),
	.foodPos(foodPos),
	.pixelReg(pixelReg),
	.init(init),
	.grow(foodReq)
);

endmodule