`include "q1.v"

module fulladder_8(a,b,cin,sum,cout);
input [7:0] a;
input [7:0] b;
input cin;
output [7:0] sum;
output cout;

wire x0,x1,x2,x3,x4,x5,x6;

fulladder a0(a[0],b[0],cin,sum[0],x0);
fulladder a1(a[1],b[1],x0,sum[1],x1);
fulladder a2(a[2],b[2],x1,sum[2],x2);
fulladder a3(a[3],b[3],x2,sum[3],x3);
fulladder a4(a[4],b[4],x3,sum[4],x4);
fulladder a5(a[5],b[5],x4,sum[5],x5);
fulladder a6(a[6],b[6],x5,sum[6],x6);
fulladder a7(a[7],b[7],x6,sum[7],cout);

endmodule


module fulladder_32(a,b,cin,sum,cout);
input [31:0] a;
input [31:0] b;
input cin;
output [31:0] sum;
output cout;

wire x1,x2,x3;

fulladder_8 a0(a[7:0],b[7:0],cin,sum[7:0],x1);
fulladder_8 a1(a[15:8],b[15:8],x1,sum[15:8],x2);
fulladder_8 a2(a[23:16],b[23:16],x2,sum[23:16],x3);
fulladder_8 a3(a[31:24],b[31:24],x3,sum[31:24],cout);

endmodule

module test();

reg [31:0] A,B;
reg Cin;
wire [31:0] S;
wire Cout;
 fulladder_32 uut(
    .a(A),
    .b(B),
    .cin(Cin),
    .sum(S),
    .cout(Cout) 
   );

   initial begin
   A = 25;
   B = 7;
   Cin = 1;
   
   #10;
   $display("A=%b B=%b Cin=%b Sum=%b Cout=%b ",A,B,Cin,S,Cout);

   end

endmodule