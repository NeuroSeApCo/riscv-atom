`include "../../Timescale.vh"
`include "block16.v"

`default_nettype none
module cesa32_16(a,b,sum);
	input [31:0]a,b;
	output [32:0]sum;

	wire c1, cout;

	block16 b0(a[15:0],b[15:0],1'b0,sum[15:0],c1);

	block16 b1(a[31:16],b[31:16],c1,sum[31:16],cout);
	assign sum[32]=cout;
endmodule