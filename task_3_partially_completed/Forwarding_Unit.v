module ForwardingUnit
  (
  input [4:0] rs1,
  input [4:0] rs2,
  input [4:0] EXMEMrd, 
  input [4:0] MEMWBrd,
  input EXMEMregWrite,
  input MEMWBregWrite,
  output reg [1:0] Forward1,
  output reg [1:0] Forward2 
  );
  
  always @ (*)
  begin

   if (EXMEMregWrite && EXMEMrd != 5'b0 && EXMEMrd == rs1)
      begin
        Forward1 = 2'b10;
      end
      
    else if (MEMWBregWrite && MEMWBrd != 5'b0 && MEMWBrd == rs1)
      begin
       Forward1 = 2'b01;
      end 
    else 
      begin
      Forward1 = 2'b00; 
      end 
    
   if (EXMEMregWrite && EXMEMrd != 5'b0 && EXMEMrd == rs2)
      begin
        Forward2 = 2'b10;
      end
      
    else if (MEMWBregWrite && MEMWBrd != 5'b0 && MEMWBrd == rs2)
      begin
       Forward2 = 2'b01;
      end 
    else 
      begin
      Forward2 = 2'b00; 
      end 
  end
endmodule
