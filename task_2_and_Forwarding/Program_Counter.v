module Program_Counter
(
  input clk, reset,
  input [63:0]PC_In,
  output reg [63:0]PC_Out
);

always@(posedge clk, posedge reset)
begin
  if(reset)
    begin
      PC_Out <= 64'b0;
    end
  else
    begin
      PC_Out <= PC_In;
    end
end

initial
begin
  PC_Out = 64'b0;
end

endmodule