module Data_Memory
(
  input [63:0]Mem_Addr, [63:0]Write_Data,
  input MemWrite, MemRead, clk,
  output reg [63:0] Read_Data
);

integer index;
reg [7:0]regs[63:0];

initial
begin

  regs[7] = 8'b00000000;
  regs[6] = 8'b00000000;
  regs[5] = 8'b00000000;
  regs[4] = 8'b00000000;
  regs[3] = 8'b00000000;
  regs[2] = 8'b00000000;
  regs[1] = 8'b00000000;
  regs[0] = 8'b00000101;


  regs[15] = 8'b00000000;
  regs[14] = 8'b00000000;
  regs[13] = 8'b00000000;
  regs[12] = 8'b00000000;
  regs[11] = 8'b00000000;
  regs[10] = 8'b00000000;
  regs[9] =  8'b00000000;
  regs[8] =  8'b00000110;

  regs[23] = 8'b00000000;
  regs[22] = 8'b00000000;
  regs[21] = 8'b00000000;
  regs[20] = 8'b00000000;
  regs[19] = 8'b00000000;
  regs[18] = 8'b00000000;
  regs[17] = 8'b00000000;
  regs[16] = 8'b00000010;

  regs[31] = 8'b00000000;
  regs[30] = 8'b00000000;
  regs[29] = 8'b00000000;
  regs[28] = 8'b00000000;
  regs[27] = 8'b00000000;
  regs[26] = 8'b00000000;
  regs[25] = 8'b00000000;
  regs[24] = 8'b00000011;

  regs[39] = 8'b00000000;
  regs[38] = 8'b00000000;
  regs[37] = 8'b00000000;
  regs[36] = 8'b00000000;
  regs[35] = 8'b00000000;
  regs[34] = 8'b00000000;
  regs[33] = 8'b00000000;
  regs[32] = 8'b00000100;

end


always@(posedge clk)
begin
  if(MemWrite)
    begin
      regs[Mem_Addr + 7] = Write_Data[63:56];
      regs[Mem_Addr + 6] = Write_Data[55:48];
      regs[Mem_Addr + 5] = Write_Data[47:40];
      regs[Mem_Addr + 4] = Write_Data[39:32];
      regs[Mem_Addr + 3] = Write_Data[31:24];
      regs[Mem_Addr + 2] = Write_Data[23:16];
      regs[Mem_Addr + 1] = Write_Data[15:8];
      regs[Mem_Addr]     = Write_Data[7:0];
    end
end

always@(*)
begin
  if(MemRead)
    begin
      Read_Data = {regs[Mem_Addr + 7] , regs[Mem_Addr + 6] , regs[Mem_Addr + 5] , regs[Mem_Addr + 4] , 
                  regs[Mem_Addr + 3] , regs[Mem_Addr + 2] , regs[Mem_Addr + 1] , regs[Mem_Addr]};
    end
end

endmodule