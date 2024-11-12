`include "decoder.v"
module test;
reg [31:0] ins;
wire r,i,j;

mips_decoder dec(ins,r,i,j);

initial begin
    ins = 32'b00000001010010110100100000100000;
    #5 $display("r=%b i=%b j=%b",r,i,j);
    #10;
    ins = 32'b00100011000100100000000000100101;
    #5 $display("r=%b i=%b j=%b",r,i,j);
    ins = 32'b00001000000000000000000000000000;
    #5 $display("r=%b i=%b j=%b",r,i,j);
    $finish;
end

endmodule