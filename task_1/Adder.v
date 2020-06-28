module Adder
(
  input [63:0]a,b,
  output reg [63:0]out
);

always@(a,b)
begin
  out = a + b;
end

endmodule