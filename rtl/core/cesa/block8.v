`include "../../Timescale.vh"
`include "fulladder.v"

`default_nettype none
module block8(a,b,cin,sum,cout);
	
	input [7:0]a,b;
	input cin;
	output [7:0]sum;
	output cout;

	wire x,y,z,w,p,q,r,s,sel,cout_pre,cout_post;
	assign x=a[7];
	assign y=b[7];
	assign z=a[6];
	assign w=b[6];

	assign p=a[5];
	assign q=b[5];
	assign r=a[4];
	assign s=b[4];

	assign sel= (x^y)&&(z^w);
	
	assign cout_pre=(p&&q) || (q&&r&&s) || (p&&r&&s);
	assign cout_post=(x&&y) || (y&&z&&w) || (x&&z&&w);

	assign cout=(~sel&&cout_post)||(sel&&cout_pre);

	wire c1, c2, c3, c4, c5, c6, c7;
	
	/* verilator lint_off UNUSED */
	wire c8;
	/* verilator lint_on UNUSED */


	fulladder f0(a[0],b[0],cin,sum[0],c1);
	fulladder f1(a[1],b[1],c1,sum[1],c2);
	fulladder f2(a[2],b[2],c2,sum[2],c3);
	fulladder f3(a[3],b[3],c3,sum[3],c4);
	fulladder f4(a[4],b[4],c4,sum[4],c5);
	fulladder f5(a[5],b[5],c5,sum[5],c6);
	fulladder f6(a[6],b[6],c6,sum[6],c7);
	fulladder f7(a[7],b[7],c7,sum[7],c8);
endmodule