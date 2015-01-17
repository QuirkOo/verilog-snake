module UP2_TOP
(
	MCLK,
	
	FLEX_DIGIT_1,
	FLEX_DIGIT_1_DP,
	FLEX_DIGIT_2,
	FLEX_DIGIT_2_DP,
	
	FLEX_MOUSE_CLK,
	FLEX_MOUSE_DATA,
	
	VGA_RED,
	VGA_BLUE,
	VGA_GREEN,
	VGA_HSYNC,
	VGA_VSYNC,
	
	LED,
	SW,
	BT,
	
	DISP1,
	DISP1_DP,
	DISP2,
	DISP2_DP,
	DISP3,
	DISP3_DP,
	DISP4,
	DISP4_DP,
	
	PS2_DATA,
	PS2_CLK,
	
	RS232_RX,
	RS232_TX,
	RS232_RTS,
	RS232_CTS,
	
	MATRIX_ROW,
	MATRIX_COL
);

/*
	==== interface description ====
*/

input MCLK;	//main clock input

output [6:0] FLEX_DIGIT_1;
output [6:0] FLEX_DIGIT_2;
output FLEX_DIGIT_1_DP;
output FLEX_DIGIT_2_DP;

output VGA_RED;
output VGA_GREEN;
output VGA_BLUE;
output VGA_HSYNC;
output VGA_VSYNC;

output [15:0] LED;
input [7:0] SW;
input [3:0] BT;

output [6:0] DISP1;
output DISP1_DP;
output [6:0] DISP2;
output DISP2_DP;
output [6:0] DISP3;
output DISP3_DP;
output [6:0] DISP4;
output DISP4_DP;

inout PS2_DATA;
inout PS2_CLK;
inout FLEX_MOUSE_DATA;
inout FLEX_MOUSE_CLK;

input RS232_RX;
output RS232_TX;
output RS232_RTS;
input RS232_CTS;

output [7:0] MATRIX_ROW;
output [15:0] MATRIX_COL;


/*
	==== functionality ====
*/

//let's save some energy
assign FLEX_DIGIT_1 = 7'b1111111;
assign FLEX_DIGIT_2 = 7'b1111111;
assign FLEX_DIGIT_1_DP = 1;
assign FLEX_DIGIT_2_DP = 1;
//assign MATRIX_ROW = 8'hFF;
//assign MATRIX_COL = 16'hFFFF;

/*
wire SLOWCLK;
wire CLK;

prescaler prescaler1 (
	.clkIn(MCLK),
	.clkOut(SLOWCLK)
);
defparam prescaler1.DIV = 2;

prescaler prescaler2 (
	.clkIn(MCLK),
	.clkOut(CLK)
);
defparam prescaler2.DIV = 1024;

wire [8*16:0] a;
assign a[15:0] = 16'b1010101010101010;
assign a[31:16] = 16'b1100110011001100;
assign a[47:32] = 16'b1111111111111110;
assign a[63:48] = 16'hFFFF;
assign a[79:64] = 16'hFFFF;
assign a[95:80] = 16'hFFFF;
assign a[111:96] = 16'hFFFF;
assign a[127:112] = 16'hFFFF;
	
display disp2(
.clk(CLK),
.pixelReg(a),
.MATRIX_ROW(MATRIX_ROW),
.MATRIX_COL(MATRIX_COL)
);
*/

wire btnUp, btnDown, btnLeft, btnRight;
wire buttons = {btnLeft, btnUp, btnRight, btnDown};

control_debouncer debouncer (
	.clk(MCLK),
	.buttonsIn(BT),
	.buttonsOut(buttons)
);

assign LED[0] = SW[0];
assign LED[1] = SW[1];

wire startGame;
assign startGame = SW[0];

snake_ctrl ctrl (
	.clk(MCLK),
	.start(startGame),
	.btnUp(btnUp),
	.btnDown(btnDown),
	.btnRight(btnRight),
	.btnLeft(btnLeft),
	.MATRIX_COL(MATRIX_COL),
	.MATRIX_ROW(MATRIX_ROW)
);

endmodule

