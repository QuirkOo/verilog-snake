module debouncer (
	input clk,
	input btn,
	output reg on
);

parameter DELAY = 25175000;
reg [31:0] counter;

always @(posedge clk, negedge btn) begin
	if (btn == 0)
		counter <= 0;
	else if (counter < DELAY)
		counter <= counter + 1;
end

always @(posedge clk)
	if (counter < DELAY)
		on <= 1;
	else 
		on <= 0;
		
endmodule