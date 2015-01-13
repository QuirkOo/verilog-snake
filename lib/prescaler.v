module prescaler (
	input clkIn,
	output reg [7:0] clkOut

);
parameter F_OSC = 25175000;
parameter DIV = 1;
parameter DELAY = F_OSC/DIV;

reg [31:0] counter;

/*
always@(posedge clkin)
	if(counter < (F_OSC/8))
		clkout <= 8'b10000000;
	else if(counter < (F_OSC/4))
		clkout <= 8'b01000000;
	else if(counter < (3*F_OSC/8))
		clkout <= 8'b00100000;
	else if(counter < (F_OSC/2))
		clkout <= 8'b00010000;
	else if(counter < (5*F_OSC/8))
		clkout <= 8'b00001000;
	else if(counter < (3*F_OSC/4))
		clkout <= 8'b00000100;
	else if(counter < (7*F_OSC/8))
		clkout <= 8'b00000010;
	else 
		clkout <= 8'b00000001;
	
*/	
always @(posedge clkIn)
	if (counter < DELAY/2)
		clkOut <= 1;
	else
		clkOut <= 0;

always @(posedge clkIn)
	if (counter < (DELAY-1))
		counter <= counter+1;
	else
		counter <= 0;
		
endmodule