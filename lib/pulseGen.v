module pulseGen (
	input clk,
	input trigger,
	output reg pulseOut
);

parameter F_OSC = 25175000;
parameter DIV = 1024;
parameter PULSE_WIDTH = F_OSC/DIV;

reg [31:0] counter;

always @(trigger) begin
	pulseOut <= 1;
	counter <= 0;
end

always @(posedge clk) begin
	if (counter < (PULSE_WIDTH-1))
		counter <= counter+1;
	else begin
		pulseOut <= 0;
	end
end

endmodule