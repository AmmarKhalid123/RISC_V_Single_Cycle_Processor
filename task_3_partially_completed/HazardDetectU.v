module Hazard_Detection_Unit (
    input IDEXEMemRead, reset, clk,
    input [4:0] IDEXERd,
    input [4:0] IFIDRs1, IFIDRs2,
    output reg PC_Write, stall, IF_ID_Write
);

always@(reset)
begin
  if (reset == 1'b1)
    begin
    stall <= 1'b0;
    IF_ID_Write <= 1'b1;
    PC_Write <= 1'b1;
    end
  end
  


always @ (*)
begin
    if (IDEXEMemRead)
    begin
        if ((IDEXERd == IFIDRs1) | (IDEXERd == IFIDRs2))
        begin
	  PC_Write <= 1'b0;
	  stall <= 1'b1;
	  IF_ID_Write <= 1'b0;
        end
    end
         
    else
        begin
            stall <= 1'b0;
            PC_Write <= 1'b1;
            IF_ID_Write <= 1'b1;
        end
       
end

endmodule