module ID_EX
(
	input [63:0] PC_out,
	output reg [63:0] PC_out2,
	input [63:0] ReadDataIn,
	output reg [63:0] ReadDataOut,
	input [63:0] ReadData2In,
	output reg [63:0] ReadData2Out,
	input [63:0] imm,
	output reg [63:0] imm2,
	input clk,
	input reset,
	input Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
	output reg Branch2, MemRead2, MemtoReg2, MemWrite2, ALUSrc2, RegWrite2,
	input [1:0] ALUOp,
	output reg [1:0] ALUOp2,
	input [4:0] Rd1,
	output reg [4:0] Rd2,
	input [3:0] Funct1,
	output reg [3:0] Funct2,
	input [4:0]Rs1In, Rs2In,
	output reg [4:0]Rs1Out, Rs2Out
);

	always@(posedge clk)
	begin
	if(reset == 1'b0)
		begin
		PC_out2 <= PC_out;
		ReadDataOut <= ReadDataIn;
		ReadData2Out <= ReadData2In;
		Branch2 <= Branch;
		MemtoReg2 <= MemtoReg;
		MemWrite2 <= MemWrite;
		MemRead2 <= MemRead;
		ALUSrc2 <= ALUSrc;
		RegWrite2 <= RegWrite;
		ALUOp2 <= ALUOp;
		imm2 <= imm;
		Rd2 <= Rd1;
		Funct2 <= Funct1;
		Rs1Out <= Rs1In;
		Rs2Out <= Rs2In;
		end
	end
	
	always@(reset)
	begin
		if(reset == 1'b1)
		begin
			PC_out2 <= 0;
			ReadDataOut <= 0;
			ReadData2Out <= 0;
			Branch2 <= 0;
			MemtoReg2 <= 0;
			MemWrite2 <= 0;
			MemRead2 <= 0;
			ALUSrc2 <= 0;
			RegWrite2 <= 0;
			ALUOp2 <= 0;
			imm2 <= 0;
			Rd2 <= 0;
			Funct2 <= 0;
			Rs1Out <= 0;
			Rs2Out <= 0;
		end
	end
	
endmodule