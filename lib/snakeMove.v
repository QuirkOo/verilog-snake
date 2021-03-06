module snake_mover (
	input clk,
	input reset,
	input lock,
	input btnUp,
	input btnDown,
	input btnLeft,
	input btnRight,
	output reg [3:0] x,
	output reg [3:0] y
);

parameter WIDTH = 16;
parameter HEIGHT = 8;
reg [3:0] dir;

wire [3:0] buttons = {btnLeft, btnDown, btnRight, btnUp};

always @(buttons) begin
	if (buttons != (dir << 2))
		dir <= buttons;
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		x <= 0;
		y <= 0;
		@(posedge clk);
	end
	else if (!lock) begin
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