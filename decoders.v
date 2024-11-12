module d2_4_decoder(a,b,enable,y0,y1,y2,y3);
input a,b,enable;
output y0,y1,y2,y3;

assign y0 = enable & ~a & ~b;
assign y1 = enable & ~a & b;
assign y2 = enable & a & ~b;
assign y3 = enable & a & b;

endmodule

module d3_8_decoder(a,b,c,y0,y1,y2,y3,y4,y5,y6,y7);
input a,b,c;
output y0,y1,y2,y3,y4,y5,y6,y7;

wire a_comp;
not(a_comp,a);

d2_4_decoder d1(b,c,a,y4,y5,y6,y7);
d2_4_decoder d2(b,c,a_comp,y0,y1,y2,y3);

endmodule

module uut();
reg A,B,C;
wire y0,y1,y2,y3,y4,y5,y6,y7;

d3_8_decoder tb(A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

initial begin
A =0;B=0;C=0;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =0;B=0;C=1;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =0;B=1;C=0;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =0;B=1;C=1;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =1;B=0;C=0;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =1;B=0;C=1;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =1;B=1;C=0;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

A =1;B=1;C=1;
#10;
$display("A=%b B=%b C=%b %b%b%b%b%b%b%b%b",A,B,C,y0,y1,y2,y3,y4,y5,y6,y7);

end
endmodule