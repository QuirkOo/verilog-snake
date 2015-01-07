module snake(
	input clk,
	input update_clk,
	output reg [7:0] row_out,
	output reg [15:0] col_out
);

reg [7:0] matrix [15:0];
integer i;

initial
	for(i = 0; i < 7; i = i+1)
		matrix[i] <= 0;

always@(posedge update_clk)
begin
	if (counter == 0)
	begin
		MATRIX_ROW <= 8'b10111111;
		MATRIX_COL <= 16'b1001111111111111;
		counter <= 1;
	end
	else
	begin
		MATRIX_ROW <= 8'b11011111;
		MATRIX_COL <= 16'b1000111111111111;
		counter <= 0;
	end
end

always@(posedge clk)
	for(i = 0; i < 7; i = i+1)
	begin
		col_out[i] <= matrix[i];
		row_out[i] <= 1;
	end

endmodule