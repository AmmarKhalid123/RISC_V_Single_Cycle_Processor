module IF_ID
(
   input [63:0] PC_Out,
   input [31:0] Instruction,
   input clk,
   input reset, IF_ID_Write, flush_IFID,
   output reg [63:0] PC_Out2,
   output reg [31:0] Instruction2
);

always@(reset)
begin
  if (reset == 1'b1)
    begin
    PC_Out2 <= 64'b0;
    Instruction2 <= 64'b0;
    end
  end
  

always@(posedge clk)
begin
  if (flush_IFID == 1'b1)
		begin
    		PC_Out2 <= 64'b0;
    		Instruction2 <= 64'b0;
		end
  else
  begin
  if (reset == 1'b0 & IF_ID_Write == 1'b1)
    begin
    PC_Out2 <= PC_Out;
    Instruction2 <= Instruction;
    end
  end
end

endmodule