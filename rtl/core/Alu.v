////////////////////////////////////////////////////////////////////   
//  RISC-V Atom 
//
//  File : Alu.v
//
//  Description : Arithmetic and logic unit for Atom core
////////////////////////////////////////////////////////////////////
`default_nettype none

`include "../Timescale.vh"

`include "cesa/cesa32_8.v"
`include "drum/DRUM4_16_u.v"

module Alu
(
    input   wire    [31:0]  A,
    input   wire    [31:0]  B,
    input   wire    [3:0]   Sel,

    output reg [31:0] Out
);

wire signed [31:0] A_s = A;

//////////////////////////////////////////////////
// X-UNIT
//wire mac_mode_on = (Sel == `__ALU_X_MAC__);

/* verilator lint_off UNUSED */
wire [32:0] xsum;
/* verilator lint_on UNUSED */

wire [31:0] xprod;

//wire [32:0] x_add_a = (mac_mode_on ? xprod : A);
//wire [32:0] x_add_b = (mac_mode_on ? Acc : B);

// AxADD
cesa32_8 xadder(A, B, xsum);

// AxMUL
DRUM4_16_u xmult(A[15:0], A[15:0], xprod);


always @(*) begin
    case(Sel)

    `__ALU_ADD__:   Out = A + B;
    `__ALU_SUB__:   Out = A - B; 
    `__ALU_XOR__:   Out = A ^ B;
    `__ALU_OR__ :   Out = A | B;
    `__ALU_AND__:   Out = A & B;
    `__ALU_SLL__:   Out = A << B[4:0];
    `__ALU_SRL__:   Out = A >> B[4:0];
    `__ALU_SRA__:   Out = A_s >>> B[4:0];

    `__ALU_X_ADD__: Out = xsum[31:0];
    `__ALU_X_MUL__: Out = xprod[31:0];
    //`__ALU_X_MAC__: Out = xsum[31:0];

    default:    Out = 32'd0;
    endcase
end
endmodule