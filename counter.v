module jk( j, k, clk, q);  
input j,k,clk;
output reg q;  
   always @ (negedge clk)  begin
      case ({j,k})  
         2'b00 :  q = q;  
         2'b01 :  q = 1'b0;  
         2'b10 :  q = 1'b1;  
         2'b11 :  q = ~q;
         default: q = 1'b0;
      endcase  
   end
endmodule  

module up_down(m,clk,y0,y1,y2,y3);
input m,clk;
output y0,y1,y2,y3;

wire z0,z1,z2;


jk f1(1'b1,1'b1,clk,y0);
xor(z0,m,y0);

jk f2(1'b1,1'b1,z0,y1);
xor(z1,m,y1);

jk f3(1'b1,1'b1,z1,y2);
xor(z2,m,y2);

jk f4(1'b1,1'b1,z2,y3);
// xor(m,y3,z3);

endmodule

module tb();
reg m,clk;
wire y0,y1,y2,y3;

up_down u1(m,clk,y0,y1,y2,y3);

initial clk=0;
always #5 clk = ~clk;


initial begin
m=0; clk = 0;
//$monitor ("time=%0t y0=%b y1=%b y2=%b y3=%b ", $time, y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
#5 $display("y0=%b y1=%b y2=%b y3=%b ",y0, y1, y2, y3);
end

initial
#1500 $finish ;
endmodule