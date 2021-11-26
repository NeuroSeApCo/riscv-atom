module P_Encoder (in_a, out_a);
input [15:0]in_a;
output reg [3:0]out_a;

always @(*)
begin
	case(in_a)
	16'h0001: out_a=4'h0;
	16'h0002: out_a=4'h1;
	16'h0004: out_a=4'h2;
	16'h0008: out_a=4'h3;
	16'h0010: out_a=4'h4;
	16'h0020: out_a=4'h5;
	16'h0040: out_a=4'h6;
	16'h0080: out_a=4'h7;
	16'h0100: out_a=4'h8;
	16'h0200: out_a=4'h9;
	16'h0400: out_a=4'ha;
	16'h0800: out_a=4'hb;
	16'h1000: out_a=4'hc;
	16'h2000: out_a=4'hd;
	16'h4000: out_a=4'he;
	16'h8000: out_a=4'hf;
	default: out_a=4'h0;
	endcase
end

endmodule