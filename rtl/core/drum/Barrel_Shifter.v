module Barrel_Shifter (in_a, count, out_a);
input [4:0]count;
input [7:0]in_a;
output [31:0]out_a;

assign out_a=({{24{1'b0}}, in_a}<<count);

endmodule