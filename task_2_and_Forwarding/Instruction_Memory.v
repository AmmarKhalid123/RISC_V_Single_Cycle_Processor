module Instruction_Memory
(
  input [63:0]Instr_Addr,
  output reg [31:0]Instruction
);

reg [7:0]regs[95:0];

initial
begin

	regs[0] = 8'b00010011; 
        regs[1] = 8'b00000001; 
        regs[2] = 8'b01010000; 
        regs[3] = 8'b00000000; 



        regs[4] = 8'b10110011; 
        regs[5] = 8'b00000001; 
        regs[6] = 8'b00000001; 
        regs[7] = 8'b00000000; 


        regs[8] = 8'b00110011; 
        regs[9] = 8'b00000010; 
        regs[10] = 8'b00100000; 
        regs[11] = 8'b00000000; 

end

always @ (Instr_Addr)
begin
  Instruction = {regs[Instr_Addr + 2'b11], regs[Instr_Addr + 2'b10], regs[Instr_Addr + 1'b1], regs[Instr_Addr]};
end

endmodule