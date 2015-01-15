module pixelGen (
	input [7:0] pos,
	input [7:0] tailPos,
	input [7:0] foodPos,
	output reg [8*16-1:0] pixelReg,
	output reg grow
);

reg [15:0] temp;
reg [3:0] x;
reg [3:0] y;

always @(tailPos) begin
	x <= tailPos[7:4];
	y <= tailPos[3:0];
	
	if (!grow) begin
		temp = pixelReg[x];
		temp[y] = 0;
		pixelReg[x] = temp;
	end
	else
		grow <= 0;
end
	
always @(pos) begin
	if (pos == foodPos)
		grow <= 1;
		
	x <= pos[7:4];
	y <= pos[3:0];	

	temp = pixelReg[x];
	temp[y] = 0;
	pixelReg[x] = temp;
end

endmodule