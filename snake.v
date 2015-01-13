module snake(
	input clk,
	input update_clk,
	output reg [7:0] output_row,
	output reg [15:0] output_col
);

wire [15:0] matrix [7:0];
assign matrix[0] = 16'b1111111111111110;
assign matrix[1] = 16'b1111111111111101;
assign matrix[2] = 16'b1111111111111011;
assign matrix[3] = 16'b1111111111110111;
assign matrix[4] = 16'b1111111111101111;
assign matrix[5] = 16'b1111111111011111;
assign matrix[6] = 16'b1111111110111111;
assign matrix[7] = 16'b1111111001111111;

wire [7:0] row;
wire [2:0] c;
wire [32:0] length;
loop loop1(
	.clk(update_clk),
	.counter(c)
);


display disp1(
	.num(c),
	.row(row)
);

always@(update_clk)
begin
	output_col <= matrix[c];
	output_row <= row;
end

/*always@(posedge update_clk)
begin
	if (counter == 0)
	begin
		output <= 8'b10111111;
		MATRIX_COL <= 16'b1001111111111111;
		counter <= 1;
	end
	else
	begin
		MATRIX_ROW <= 8'b11011111;
		MATRIX_COL <= 16'b1000111111111111;
		counter <= 0;
	end
end*/



endmodule