`include "../../Timescale.vh"
`include "block8.v"

`default_nettype none
module cesa32_8(a,b,sum);				
	input [31:0]a,b;
	output [32:0]sum;

wire c1, c2, c3, cout;

block8 b0(a[7:0],b[7:0],1'b0,sum[7:0],c1);
block8 b1(a[15:8],b[15:8],c1,sum[15:8],c2);

block8 b2(a[23:16],b[23:16],c2,sum[23:16],c3);
block8 b3(a[31:24],b[31:24],c3,sum[31:24],cout);
assign sum[32]=cout;
endmodule