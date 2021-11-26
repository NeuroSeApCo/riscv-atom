`include "../../Timescale.vh"
`include "block4.v"

`default_nettype none
module cesa32_4(a,b,sum);				
	input [31:0]a,b;
	output [32:0]sum;

	wire c1, c2, c3, c4, c5, c6, c7, cout;

	block4 b0(a[3:0],b[3:0],1'b0,sum[3:0],c1);
	block4 b1(a[7:4],b[7:4],c1,sum[7:4],c2);
	block4 b2(a[11:8],b[11:8],c2,sum[11:8],c3);
	block4 b3(a[15:12],b[15:12],c3,sum[15:12],c4);
	

	block4 b4(a[19:16],b[19:16],c4,sum[19:16],c5);
	block4 b5(a[23:20],b[23:20],c5,sum[23:20],c6);
	block4 b6(a[27:24],b[27:24],c6,sum[27:24],c7);
	block4 b7(a[31:28],b[31:28],c7,sum[31:28],cout);
	assign sum[32]=cout;
endmodule