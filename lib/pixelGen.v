module pixel_gen (
	input genreq,
	input [7:0] pos,
	input [7:0] tailPos,
	input [7:0] foodPos,
	input init,
	output reg [8*16-1:0] pixelReg,
	output reg grow
);

reg [15:0] temp;
always @(posedge genreq or posedge init) begin
	if (init) begin
		pixelReg[15:0] <= 16'b1111111111111110;
		pixelReg[31:16] <= 16'b1111111111111110;
		pixelReg[47:32] <= 16'b1111111111111110;
		pixelReg[63:48] <= 16'hFFFF;
		pixelReg[79:64] <= 16'hFFFF;
		pixelReg[95:80] <= 16'hFFFF;
		pixelReg[111:96] <= 16'hFFFF;
		pixelReg[127:112] <= 16'hFFFF;
	end
	else begin
		//pixelReg = pixelReg + 1;
	
		//if (pos == foodPos)
		//	grow <= 1;
		temp = pixelReg[pos[7:4]];
		temp[pos[3:0]] = 0;
		pixelReg[pos[7:4]] = temp;
	
		//if (!grow) begin
		temp = pixelReg[tailPos[7:4]];
		temp[tailPos[3:0]] = 1;
		pixelReg[tailPos[7:4]] = temp;
		//end
		//else
		//	grow <= 0;
	end
end

endmodule