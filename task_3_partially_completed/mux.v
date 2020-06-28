module mux
(
	input [63:0]a, [63:0]b,
	input sel,
	output reg [63:0]data_out
);

always @ (sel or a or b)
  begin
    case (sel)
	   1'b0: data_out = a;
	   1'b1: data_out = b;
    endcase
  end
endmodule