module pixelGen (
	input [7:0] pos,
	input [7:0] tailPos,
	input [7:0] foodPos,
	output reg [8*16-1:0] pixelReg,
	output reg grow
);

reg [15:0] temp;

always @(tailPos or pos) begin
	if (pos == foodPos)
		grow = 1;
		
	temp = pixelReg[pos[7:4]];
	temp[pos[3:0]] = 0;
	pixelReg[pos[7:4]] = temp;

	if (!grow) begin
		temp = pixelReg[tailPos[7:4]];
		temp[tailPos[3:0]] = 0;
		pixelReg[tailPos[7:4]] = temp;
	end
	else
		grow = 0;
end

endmodule