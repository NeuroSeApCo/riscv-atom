// Config file
`define RESET_PC_ADDRESS 32'h0000000

`define __NOP_INSTRUCTION__ 32'h00000013    // NOP = addi x0, x0, 0

// IMM_TYPE
`define __I_IMMIDIATE__ 3'd0
`define __S_IMMIDIATE__ 3'd1
`define __B_IMMIDIATE__ 3'd2
`define __U_IMMIDIATE__ 3'd3
`define __J_IMMIDIATE__ 3'd4

// ALU
`define __ALU_ADD__ 4'd0
`define __ALU_SUB__ 4'd1
`define __ALU_XOR__ 4'd2
`define __ALU_OR__  4'd3
`define __ALU_AND__ 4'd4
`define __ALU_SLL__ 4'd5
`define __ALU_SRL__ 4'd6
`define __ALU_SRA__ 4'd7

`define __ALU_X_CONF__ 4'd8
`define __ALU_X_ADD__ 4'd9
`define __ALU_X_MUL__ 4'd10
`define __ALU_X_MAC__ 4'd11

// COMPARATOR
`define __CMP_UN__  3'd0
`define __CMP_EQ__  3'd1
`define __CMP_NQ__  3'd2
`define __CMP_LT__  3'd3
`define __CMP_GE__  3'd4
`define __CMP_LTU__ 3'd5
`define __CMP_GEU__ 3'd6
