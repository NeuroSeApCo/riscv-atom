`include "../../Timescale.vh"
`include "fulladder.v"

`default_nettype none
module block16(a,b,cin,sum,cout);
	
	input [15:0]a,b;
	input cin;
	output [15:0]sum;
	output cout;

	wire x,y,z,w,p,q,r,s,sel,cout_pre,cout_post;
	assign x=a[15];
	assign y=b[15];
	assign z=a[14];
	assign w=b[14];

	assign p=a[13];
	assign q=b[13];
	assign r=a[12];
	assign s=b[12];

	assign sel= (x^y)&&(z^w);
	
	assign cout_pre=(p&&q) || (q&&r&&s) || (p&&r&&s);
	assign cout_post=(x&&y) || (y&&z&&w) || (x&&z&&w);

	assign cout=(~sel&&cout_post)||(sel&&cout_pre);

	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;

	fulladder f0(a[0],b[0],cin,sum[0],c1);
	fulladder f1(a[1],b[1],c1,sum[1],c2);
	fulladder f2(a[2],b[2],c2,sum[2],c3);
	fulladder f3(a[3],b[3],c3,sum[3],c4);
	fulladder f4(a[4],b[4],c4,sum[4],c5);
	fulladder f5(a[5],b[5],c5,sum[5],c6);
	fulladder f6(a[6],b[6],c6,sum[6],c7);
	fulladder f7(a[7],b[7],c7,sum[7],c8);
	fulladder f8(a[8],b[8],c8,sum[8],c9);
	fulladder f9(a[9],b[9],c9,sum[9],c10);
	fulladder f10(a[10],b[10],c10,sum[10],c11);
	fulladder f11(a[11],b[11],c11,sum[11],c12);
	fulladder f12(a[12],b[12],c12,sum[12],c13);
	fulladder f13(a[13],b[13],c13,sum[13],c14);
	fulladder f14(a[14],b[14],c14,sum[14],c15);
	fulladder f15(a[15],b[15],c15,sum[15],c16);
endmodule
