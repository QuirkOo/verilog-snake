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


	
display disp2(
.clk(CLK),
.MATRIX_ROW(MATRIX_ROW),
.MATRIX_COL(MATRIX_COL)
);

wire btnUp, btnDown, btnLeft, btnRight;
wire buttons = {btnLeft, btnUp, btnRight, btnDown};

controlDebouncer debouncer (
	.clk(MCLK),
	.buttonsIn(BT),
	.buttonsOut(buttons)

//snakeCtrl ctrl (
//	.clk(MCLK),
//	.reset(SW[0]),
//	.btnUp(btnUp),
//	.btnDown(btnDown),
//	.btnRight(btnRight),
//	.btnLeft(btnLeft),
//	.MATRIX_COL(MATRIX_COL),
//	.MATRIX_ROW(MATRIX_ROW)
//	);

endmodule

