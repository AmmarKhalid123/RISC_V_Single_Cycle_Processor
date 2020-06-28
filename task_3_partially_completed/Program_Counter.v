module Program_Counter
(
  input clk, reset, PC_Write,
  input [63:0]PC_In,
  output reg [63:0]PC_Out
);

initial
begin
  PC_Out = 64'b0;
end

always@(posedge clk)
begin
  if(reset)
    begin
      PC_Out <= 64'b0;
    end
  else if(PC_Write == 1'b0)
    begin
      PC_Out = PC_Out;
    end
  else
    begin
      PC_Out = PC_In;
    end
end


endmodule