module EX_MEM
(
	input [63:0] PCSum,
	output reg [63:0] PCSum2,
	input [63:0] ALUResult,
	output reg [63:0] ALUResult2,
	input [63:0] ReadData2in,
	output reg [63:0] ReadData2out,
	input clk, reset, flush_EXMEM,
	input Branch, MemRead, MemtoReg, MemWrite, RegWrite, Zero,
	output reg Branch2, MemRead2, MemtoReg2, MemWrite2, RegWrite2, Zero2,
	input [4:0] Rd,
	output reg [4:0] Rd2
);

	always@(posedge clk)
	begin
		if (flush_EXMEM == 1'b1)
		begin
			PCSum2 <= 0;
			ALUResult2 <= 0;
			ReadData2out <= 0;
			Branch2 <= 0;
			MemtoReg2 <= 0;
			MemWrite2 <= 0;
			MemRead2 <= 0;
			RegWrite2 <= 0;
			Rd2 <= 0;
			Zero2 <= 0;
		end
		else
		begin
		if(reset == 1'b0)
		begin
		PCSum2 <= PCSum;
		ALUResult2 <= ALUResult;
		ReadData2out <= ReadData2in;
		Branch2 <= Branch;
		MemtoReg2 <= MemtoReg;
		MemWrite2 <= MemWrite;
		MemRead2 <= MemRead;
		RegWrite2 <= RegWrite;
		Rd2 <= Rd;
		Zero2 <= Zero;
		end
		end
	end
	
	always@(posedge reset)
	begin
		if(reset == 1'b1)
		begin
			PCSum2 <= 0;
			ALUResult2 <= 0;
			ReadData2out <= 0;
			Branch2 <= 0;
			MemtoReg2 <= 0;
			MemWrite2 <= 0;
			MemRead2 <= 0;
			RegWrite2 <= 0;
			Rd2 <= 0;
			Zero2 <= 0;
		end
	end
	
endmodule