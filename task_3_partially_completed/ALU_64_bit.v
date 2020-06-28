module ALU_64_bit
(
  input [63:0] a,
  input [63:0] b,
  input [3:0] ALUOp,
  output reg [63:0] Result,
  output reg Zero
  
);

always @(*)
    begin
    case({ALUOp})
        4'h0 : Result <= a & b;
        4'h1 : Result <= a | b;
        4'h2 : Result <= a + b;
        4'h6 : Result <= a - b;
	4'h3 : Result <= a - b;
	4'h4 : Result <= a << b;
	4'h7 : Result <= (a < b) ? 1 : 0; // to be checked, ke a < b will return 1.
        default : Result <= ~(a | b);
     endcase
	case(ALUOp)
		4'h6 : Zero = Result?0:1;
		4'h3 : Zero = Result?1:0;
		4'h7 : Zero = Result;
        endcase
    end

endmodule