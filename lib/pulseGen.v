module pulseGen (
	input clk,
	input trigger,
	output reg pulseOut
);

parameter F_OSC = 25175000;
parameter DIV = 1024;
parameter PULSE_WIDTH = F_OSC/DIV;

reg [31:0] counter;
reg enable;

always @(trigger) begin
	enable <= 1;
	@(posedge clk) enable <= 0;
end

always @(posedge clk or posedge enable) begin
	if (enable) begin
		pulseOut <= 1;
		counter <= 0;
	end
	else begin
		if (counter < (PULSE_WIDTH-1))
			counter <= counter+1;
		else 
			pulseOut <= 0;
	end
end

endmodule