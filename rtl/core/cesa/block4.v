`include "../../Timescale.vh"
`include "fulladder.v"

`default_nettype none
module block4(a,b,cin,sum,cout);
	
	input [3:0]a,b;
	input cin;
	output [3:0]sum;
	output cout;

	wire x,y,z,w,p,q,r,s,sel,cout_pre,cout_post;
	assign x=a[3];
	assign y=b[3];
	assign z=a[2];
	assign w=b[2];

	assign p=a[1];
	assign q=b[1];
	assign r=a[0];
	assign s=b[0];

	assign sel= (x^y)&&(z^w);
	
	assign cout_pre=(p&&q) || (q&&r&&s) || (p&&r&&s);
	assign cout_post=(x&&y) || (y&&z&&w) || (x&&z&&w);

	assign cout=(~sel&&cout_post)||(sel&&cout_pre);   //mux

	wire c1, c2, c3;
	/* verilator lint_off UNUSED */
	wire c4;
	/* verilator lint_on UNUSED */
	fulladder f0(a[0],b[0],cin,sum[0],c1);
	fulladder f1(a[1],b[1],c1,sum[1],c2);
	fulladder f2(a[2],b[2],c2,sum[2],c3);
	fulladder f3(a[3],b[3],c3,sum[3],c4);

endmodule