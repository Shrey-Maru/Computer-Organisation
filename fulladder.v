module fulladder(a,b,cin,sum,cout);
    input a;
    input b;
    input cin;
    output sum;
    output cout;
    
    wire x1,x2,x3;
    xor(x1,a,b);
    xor(sum,x1,cin);
    and(x2,a,b);
    and(x3,x1,cin);
    or(cout,x2,x3);

endmodule

// module Testbench_structural_adder();
//  reg A,B,Cin;
//  wire S,Cout;  
//  //Verilog code for the structural full adder 
//  fulladder uut(
//     .a(A),
//     .b(B),
//     .cin(Cin),
//     .sum(S),
//     .cout(Cout) 
//    );
//  initial begin
//    A = 0;
//    B = 0;
//    Cin = 0;
   
//    #10;
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//    A = 0;
//    B = 0;
//    Cin = 1;
//    #10;  
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//    A = 0;
//    B = 1;
//    Cin = 0;
//    #10;
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//    A = 0;
//    B = 1;
//    Cin = 1;
//    #10;
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//    A = 1;
//    B = 0;
//    Cin = 0;
//    #10;
//    A = 1;
//    B = 0;
//    Cin = 1;
//    #10;
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//    A = 1;
//    B = 1;
//    Cin = 0;
//    #10;  
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//    A = 1;
//    B = 1;
//    Cin = 1;
//    #10;  
//    $display("%b %b %b %b %b ",A,B,Cin,S,Cout);
//   end
      
// endmodule 