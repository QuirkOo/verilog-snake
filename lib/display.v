module display (
	input clk,
	input aclr,
	input [8*16-1:0] pixelReg,
	output reg [7:0] MATRIX_ROW,
	output reg [15:0] MATRIX_COL
);

reg [2:0] i = 0;

always @(posedge clk) begin
	if (~aclr) begin
		case (i)
			3'b001: begin
				MATRIX_ROW <= 8'b11111110;
				MATRIX_COL[15:0] <= pixelReg[15:0];
			end
			3'b010: begin
				MATRIX_ROW <= 8'b11111101;
				MATRIX_COL[15:0] <= pixelReg[31:16];
			end
			3'b011: begin
				MATRIX_ROW <= 8'b11111011;
				MATRIX_COL[15:0] <= pixelReg[47:32];
			end
			3'b100: begin
				MATRIX_ROW <= 8'b11110111;
				MATRIX_COL[15:0] <= pixelReg[63:48];
			end
			3'b101: begin
				MATRIX_ROW <= 8'b11101111;
				MATRIX_COL[15:0] <= pixelReg[79:64];
			end
			3'b110: begin
				MATRIX_ROW <= 8'b11011111;
				MATRIX_COL[15:0] <= pixelReg[95:80];
			end
			3'b111: begin
				MATRIX_ROW <= 8'b10111111;
				MATRIX_COL[15:0] <= pixelReg[111:96];
			end
			3'b000: begin
				MATRIX_ROW <= 8'b01111111;
				MATRIX_COL[15:0] <= pixelReg[127:112];
			end
		endcase
		i = i + 1;
	end
	else MATRIX_ROW <= 8'b11111111;
end

endmodule