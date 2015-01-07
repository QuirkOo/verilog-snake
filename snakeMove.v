module snakeMove (
	input clk,
	input reset,
	input btnUp,
	input btnDown,
	input btnLeft,
	input btnRight,
	output reg [3:0] x,
	output reg [3:0] y
);

parameter WIDTH = 16;
parameter HEIGHT = 8;
wire [3:0] dir;

wire [3:0] buttons = {btnLeft, btnDown, btnRight, btnUp};
assign dir = buttons;

always @(posedge clk or negedge reset) begin
	if (reset == 0) begin
		x <= 0;
		y <= 0;
		@(posedge clk);
	end
	else begin
		case (dir)
			4'b0001: x <= x + 1;
			4'b0010: y <= y + 1;
			4'b0100: x <= x - 1;
			4'b1000: y <= y - 1; 
		endcase

		if (x >= WIDTH)
			x <= 0;
		if (y >= HEIGHT)
			y <= 0;
	end
end

endmodule