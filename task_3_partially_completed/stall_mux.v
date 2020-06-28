module stall_mux
(
input [7:0] a,
input[7:0] b,
input stall,
output reg [7:0] out
);

always @ (*)

begin

case(stall)

    1'b0: out = a;

    1'b1: out = b;


endcase

end

endmodule