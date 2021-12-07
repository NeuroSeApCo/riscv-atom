`include "cesa/cesa32_8.v"
`include "drum/DRUM4_16_u.v"

module ACU
(
    input   wire    [31:0]  A, Acc,
    input   wire    [31:0] B,
    input   wire    [3:0]   Sel,

    output reg [31:0] xprod, 
    output reg [32:0] xsum
);

wire signed [31:0] A_s = A;

//////////////////////////////////////////////////
// X-UNIT
wire mac_mode_on = (Sel == 0100);

wire [32:0] x_add_a = (mac_mode_on ? xprod : A);
wire [32:0] x_add_b = (mac_mode_on ? Acc : B);

// AxADD
cesa32_8 xadder(A, B, xsum);

// AxMUL
DRUM4_16_u xmult(A[15:0], A[15:0], xprod);
endmodule