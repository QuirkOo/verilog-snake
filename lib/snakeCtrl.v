module snake_ctrl (
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

wire displayClk;
wire updateClk;
clk_setup setup (clk, displayClk, updateClk);

wire [3:0] x, y;
wire [7:0] pos = {x, y};
wire [7:0] tailPos;

wire rdenable, wrenable;
assign rdenable = 1;
assign wrenable = 1;

fifo body (
	.clk(updateClk),
	.aclr(start),
	.rdenable(rdenable),
	.wrenable(wrenable),
	.datain(pos),
	.dataout(tailPos)
);

snake_mover move (
	.clk(updateClk),
	.reset(~start),
	.lock(lock),
	.btnUp(btnUp),
	.btnDown(btnDown),
	.btnLeft(btnLeft),
	.btnRight(btnRight),
	.x(x),
	.y(y)
);

display disp (
	.aclr(~start),
	.clk(displayClk),
	.pixelReg(pixelReg),
	.MATRIX_ROW(MATRIX_ROW),
	.MATRIX_COL(MATRIX_COL)
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

pixel_gen pixel (
	.genreq(updateClk),
	.pos(pos),
	.tailPos(tailPos),
	.foodPos(foodPos),
	.pixelReg(pixelReg),
	.init(~start),
	.grow(foodReq)
);

endmodule