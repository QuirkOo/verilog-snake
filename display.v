module display (
	input clk,
	input [15:0] row,
	output reg [15:0] matrixRow,
	output reg [7:0] matrixCol
);

parameter width = 16;
parameter height = 8;

reg [width-1:0] i = 0;

always @(posedge clk) begin
	matrixRow[i] <= 0;
	matrixCol <= row[i];
	i = i + 1;
	if (i > height-1)
		i = 0;
end

endmodule