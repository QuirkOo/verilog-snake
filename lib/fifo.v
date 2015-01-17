module fifo (
	input clk,
	input aclr,	// Asynchronous clear
	input rdenable,	// Read enable
	input wrenable,	// Write enable
	input [7:0] datain,
	output reg [7:0] dataout
);

parameter MEM_WIDTH = 7;
parameter MEM_SIZE = (1 << MEM_WIDTH);

reg [7:0] mem [MEM_SIZE-1:0];
reg [MEM_WIDTH-1:0] rdptr, wrptr; 

always @(posedge clk or posedge aclr) begin
	if (aclr) begin
		mem[0] <= 8'b00000000;
		mem[1] <= 8'b00000001;
		mem[2] <= 8'b00000010;
		rdptr <= 0;
		wrptr <= 3;
	end
	else begin
		if (rdenable) begin
			dataout <= mem[rdptr];
			rdptr <= rdptr +1;
			
			if (wrenable) begin
				mem[wrptr] <= datain;			
				wrptr <= wrptr +1;
			end
		end
	end
end

endmodule