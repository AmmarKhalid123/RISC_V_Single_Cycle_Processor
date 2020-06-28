module registerFile
(
  input clk, reset, RegWrite,
  input [4:0]RS1, RS2, RD,
  input [63:0]WriteData,
  output reg [63:0]ReadData1, ReadData2
);

reg [63:0]regs[31:0];

integer index;

initial
begin
for(index = 0; index < 32; index = index + 1)
  begin
    regs[index] = index;
  end
end

always@(posedge clk)
begin
  if(RegWrite)
    begin
      if(RD != 5'b0)
        regs[RD] = WriteData;
    end
end

always@(RS1, RS2, reset,regs)
begin
  if(reset)
    begin
      ReadData1 = 64'b0;
      ReadData2 = 64'b0;
    end
  else
    begin
      ReadData1 = regs[RS1];
      ReadData2 = regs[RS2];
    end
end
endmodule
