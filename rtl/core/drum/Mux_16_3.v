module Mux_16_3 (in_a, select, out);
input [3:0]select;
/* verilator lint_off UNUSED */
input [15:0]in_a;
/* verilator lint_on UNUSED */
output reg [1:0]out;

always @(*)
begin
	case(select)
    4'h4: begin out={in_a[3],in_a[2]}; end
    4'h5: begin out={in_a[4],in_a[3]}; end
	4'h6: begin out={in_a[5],in_a[4]}; end
	4'h7: begin out={in_a[6],in_a[5]}; end
	4'h8: begin out={in_a[7],in_a[6]}; end
	4'h9: begin out={in_a[8],in_a[7]}; end
	4'ha: begin out={in_a[9],in_a[8]}; end
	4'hb: begin out={in_a[10],in_a[9]}; end
	4'hc: begin out={in_a[11],in_a[10]}; end
	4'hd: begin out={in_a[12],in_a[11]}; end
	4'he: begin out={in_a[13],in_a[12]}; end
	4'hf: begin out={in_a[14],in_a[13]}; end
	default: begin out=2'b00; end
	endcase
end
endmodule