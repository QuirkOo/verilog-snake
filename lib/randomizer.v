module randomizer (
	input clk,
	input req,
	output reg [3:0] x,
	output reg [3:0] y
);

parameter rangeX = 16;
parameter rangeY = 8;

reg [3:0] countX;
reg [3:0] countY;

always @(posedge clk) begin
	countX <= countX + 1;
	countY <= countY + 1;
	if (countX >= rangeX)
		countX <= 0;
	if (countY >= rangeY)
		countY <= 0;
end

always @(posedge req) begin
	x <= countX;
	y <= countY;
end

endmodule