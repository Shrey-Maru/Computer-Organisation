module mips_decoder (
    input [31:0] instruction,
    output rtype,itype,jtype
);
wire[5:0] opcode;


assign opcode = instruction[31:26];


// assign rtype = (opcode == 6'b000000) ? 1 : 0;


// assign itype = (opcode == 6'b001000) || (opcode == 6'b001001) || (opcode == 6'b001100) || (opcode == 6'b001101) || (opcode == 6'b101010) || (opcode == 6'b001111) || (opcode == 6'b100000) || (opcode == 6'b100011) || (opcode == 6'b101011) ? 1 : 0;


// //assign jtype = (opcode == 6'b000010) || (opcode == 6'b000011) ? 1 : 0;

// assign jtype = ~(rtype || itype);

assign rtype = (opcode == 6'b000000) ? 1 : 0;


assign itype = (opcode == 6'b001000) || (opcode == 6'b001001) || (opcode == 6'b001100) || (opcode == 6'b001101) || (opcode == 6'b101010) || (opcode == 6'b001111) || (opcode == 6'b100000) || (opcode == 6'b100011) || (opcode == 6'b101011) ? 1 : 0;


assign jtype = ~(rtype || itype);

endmodule