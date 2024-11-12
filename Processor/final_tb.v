`include "final.v"

module test;

    reg clk;
    wire [31:0] c;

    bubble b1(clk,c);

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        // #10 $display
        $dumpfile("test.vcd");
        $dumpvars(0,test);
        // #40 $display("c = %b",c);
        // #50 $display("c = %b",c);
        #8000 $finish;
    end
endmodule