module display (
	input clk,
	input [7:0] pos,
	input [7:0] tailPos,
	output reg [7:0] MATRIX_ROW,
	output reg [15:0] MATRIX_COL
);

reg [2:0] i = 0;

reg [8*15:0] pixelRow;
reg [15:0] temp;

initial
	pixelRow[15:0] <= 16'b1010101010101010;

always @(posedge clk) begin
	case (i)
		3'b001: MATRIX_ROW <= 8'b11111110;
		3'b010: MATRIX_ROW <= 8'b11111101;
		3'b011: MATRIX_ROW <= 8'b11111011;
		3'b100: MATRIX_ROW <= 8'b11110111;
		3'b101: MATRIX_ROW <= 8'b11101111;
		3'b110: MATRIX_ROW <= 8'b11011111;
		3'b111: MATRIX_ROW <= 8'b10111111;
		3'b000: MATRIX_ROW <= 8'b01111111;
	endcase
		
	MATRIX_COL <= pixelRow[15:0];
	i = i + 1;
	
end

always @(tailPos or pos) begin
	temp = pixelRow[tailPos[7:4]];
	temp[tailPos[3:0]] = 1;
	pixelRow[tailPos[7:4]] = temp;
	
	temp = pixelRow[pos[7:4]];
	temp[pos[3:0]] = 0;
	pixelRow[pos[7:4]] = temp;
end

endmodule