`include "../../Timescale.vh"

`default_nettype none
module fulladder(a,b,cin,sum,cout);     //working #tested
	input a,b,cin;
	output sum,cout;

	assign sum=a^b^cin;
	assign cout=(a&b) || (a^b)&cin;
endmodule