module RISC_V_PROCESSOR
(
	input wire clk,
	input wire reset
);


wire [63:0]pc_input;
wire [63:0]pc_output;

Program_Counter pc1
(
  .PC_In(pc_input),
  .PC_Out(pc_output),
  .clk(clk),
  .reset(reset)
);

wire [31:0]im_out, Instruction1;
wire [63:0]PC_Out1, PC_Out2;


Instruction_Memory im1
(
  .Instr_Addr(pc_output),
  .Instruction(im_out)
);


IF_ID buffer1
(
.PC_Out(pc_output),
.Instruction(im_out),
.PC_Out2(PC_Out1),
.Instruction2(Instruction1),
.clk(clk),
.reset(reset)
);

wire [6:0]opcode;
wire [4:0]rd, Rd, Rd1, Rd2;
wire [2:0]funct3;
wire [4:0]rs1, Rs1;
wire [4:0]rs2, Rs2;
wire [6:0]funct7;
wire [3:0]Funct1;

instruction_parser ip1
(
  .instruction(Instruction1),
  .opcode(opcode),
  .rd(rd),
  .funct3(funct3),
  .rs1(rs1),
  .rs2(rs2),
  .funct7(funct7)
);

reg [63:0]four;

initial
  four <= 64'b100;

wire [63:0]PC_inc4_Out;

Adder a1
(
  .a(pc_output),
  .b(four),
  .out(PC_inc4_Out)
);

wire Branch, Branch1, Branch2;
wire MemRead, MemRead1, MemRead2;
wire MemtoReg, MemtoReg1, MemtoReg2;
wire MemWrite, MemWrite1, MemWrite2;
wire ALUSrc, ALUSrc1, ALUSrc2;
wire RegWrite, RegWrite1, RegWrite2, RegWrite3;
wire [1:0]ALUOp, ALUOp1, ALUOp2;
wire [1:0] ForwardA, ForwardB;

Control_Unit cu1
(
  .Opcode(opcode),
  .Branch(Branch),
  .MemRead(MemRead),
  .MemtoReg(MemtoReg),
  .MemWrite(MemWrite),
  .ALUSrc(ALUSrc),
  .RegWrite(RegWrite),
  .ALUOp(ALUOp)
);

wire [63:0]PC_inc_Out;

wire [63:0]aluout;
wire aluzero, aluzero1;
wire PCSrc = Branch2 & aluzero1;
wire [63:0] PC_inc_Out1;

mux m1
(
  .a(PC_inc4_Out),
  .b(PC_inc_Out1),
  .sel(PCSrc),
  .data_out(pc_input)
);

wire [63:0]Data_mem_mux_Out;
wire [63:0]readdata1;
wire [63:0]readdata2;


registerFile rf1
(
  .clk(clk),
  .reset(reset),
  .RegWrite(RegWrite3),
  .RS1(rs1),
  .RS2(rs2),
  .RD(Rd2),
  .WriteData(Data_mem_mux_Out),
  .ReadData1(readdata1),
  .ReadData2(readdata2)
);

wire [63:0]immdata_out, imm_data1;

imm_data immdata1
(
  .instruction(Instruction1),
  .imm_data(immdata_out)
);

wire [63:0] ReadData1tomux, ReadData2tomux;

ID_EX buffer2
	(
		.PC_out(PC_Out1),
		.ReadDataIn(readdata1),
		.ReadData2In(readdata2),
		.imm(immdata_out),
		.clk(clk),
		.reset(reset),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.ALUOp(ALUOp),
		.Rd1(rd),
		.Rs1In(rs1),
		.Rs2In(rs2),
		.Funct1({1'b0,im_out[14:12]}), // Instruction1 is output from IF/EX
		.PC_out2(PC_Out2),
		.ReadDataOut(ReadData1tomux),
		.ReadData2Out(ReadData2tomux),
		.imm2(imm_data1),
		.Branch2(Branch1),
		.MemRead2(MemRead1),
		.MemWrite2(MemWrite1),
		.MemtoReg2(MemtoReg1),
		.ALUSrc2(ALUSrc1),
		.RegWrite2(RegWrite1),
		.ALUOp2(ALUOp1),
		.Rd2(Rd),
		.Rs1Out(Rs1),
		.Rs2Out(Rs2),
		.Funct2(Funct1)
	);

wire [3:0]aluc_out;

ALU_Control alucon1
(
  .ALUOp(ALUOp1),
  .Funct(Funct1), // inst[30] to 1'b0
  .Operation(aluc_out)
);

ForwardingUnit FU
	(
		.rs1(Rs1),
		.rs2(Rs2),
		.EXMEMrd(Rd1),
		.MEMWBrd(Rd2),
		.EXMEMregWrite(RegWrite2),
		.MEMWBregWrite(RegWrite3),
		.Forward1(ForwardA),
		.Forward2(ForwardB)
	);

Adder a2
(
  .a(PC_Out2),
  .b(imm_data1 << 1),
  .out(PC_inc_Out)
);

wire [63:0] ALU_Out1, ALU_Out2, ForwardAmux_Out, ForwardBmux_Out, ALU_mux_Out;

mux2 ForwardAmux
	(
		.a(ReadData1tomux),
		.b(Data_mem_mux_Out),
		.c(ALU_Out1),
		.sel(ForwardA),
		.data_out(ForwardAmux_Out)
	);

mux2 ForwardBmux
(
  .a(ReadData2tomux),
  .b(Data_mem_mux_Out),
  .c(ALU_Out1),
  .sel(ForwardB),
  .data_out(ForwardBmux_Out)
);

mux ALU_mux
(
  .a(ForwardBmux_Out),
  .b(imm_data1),
  .sel(ALUSrc1),
  .data_out(ALU_mux_Out)
);
ALU_64_bit alu64
(
  .a(ForwardAmux_Out),
  .b(ALU_mux_Out),
  .ALUOp(aluc_out),
  .Zero(aluzero),
  .Result(aluout)
);


EX_MEM buffer3
(
  .PCSum(PC_inc_Out),
  .ALUResult(aluout),
  .ReadData2in(ForwardBmux_Out),
  .clk(clk),
  .reset(reset),
  .Branch(Branch1),
  .MemRead(MemRead1),
  .MemtoReg(MemtoReg1),
  .MemWrite(MemWrite1),
  .RegWrite(RegWrite1),
  .Zero(aluzero),
  .Rd(Rd),
  .PCSum2(PC_inc_Out1),
  .ALUResult2(ALU_Out1),
  .ReadData2out(ForwardBmux_Out1),
  .Branch2(Branch2),
  .MemRead2(MemRead2),
  .MemtoReg2(MemtoReg2),
  .MemWrite2(MemWrite2),
  .RegWrite2(RegWrite2),
  .Zero2(aluzero1),
  .Rd2(Rd1)
);


wire [63:0]datamem_out, Read_data1;

Data_Memory datam
(
  .Mem_Addr(ALU_Out1),
  .Write_Data(ForwardBmux_Out1),
  .clk(clk),
  .MemWrite(MemWrite2),
  .MemRead(MemRead2),
  .Read_Data(datamem_out)
);

MEM_WB buffer4
(
  .Result(ALU_Out1),
  .Read_Data(datamem_out),
  .rd1(Rd1),
  .MemtoReg(MemtoReg2),
  .RegWrite(RegWrite2),
  .clk(clk),
  .reset(reset),
  .Result2(ALU_Out2),
  .Read_Data2(Read_data1),
  .rd2(Rd2),
  .MemtoReg2(MemtoReg3),
  .RegWrite2(RegWrite3)		
);

mux m2
(
  .a(ALU_Out2),
  .b(Read_data1),
  .sel(MemtoReg3),
  .data_out(Data_mem_mux_Out)
);

endmodule