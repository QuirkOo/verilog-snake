module fifo (
	input clk,
	input aclr,
	input [7:0] datain,
	output reg [7:0] dataout
);

parameter MEM_WIDTH = 7;
parameter MEM_SIZE = (1 << MEM_WIDTH);
reg [7:0] mem[MEM_SIZE-1:0];
reg [MEM_WIDTH-1:0] rdptr, wrptr; 

always @(posedge clk or posedge aclr) begin
	if (aclr) begin
		rdptr <= 0;
		wrptr <= 0;
	end
	else begin
		dataout = mem[rdptr];
		mem[wrptr] = datain;
		rdptr <= rdptr +1;
		wrptr <= wrptr +1;
	end
end

endmodule