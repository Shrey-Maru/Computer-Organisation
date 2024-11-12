module mux_4to1(a,b,c,d,s0,s1,Y);
input [31:0] a,b,c,d;
input s0,s1;
output reg [31:0] Y;

reg [1:0] s;

always @(*) begin
    s = {s1,s0};
    case (s)
    2'b00 : Y = a;
    2'b01 : Y = b;
    2'b10 : Y = c;
    2'b11 : Y = d;
        
    endcase
end

endmodule

module tb();
reg [31:0] a,b,c,d;
reg s0,s1;
wire [31:0] out;
mux_4to1 m1(a,b,c,d,s0,s1,out);
initial begin
a=16778;b=2;c=3;d=4; s1 = 0; s0 = 0;
#10;
$display("A=%b B=%b C=%b D=%b Y=%b",a,b,c,d,out);

a=1;b=2;c=3;d=4; s1 = 0; s0 = 1;
#10;
$display("A=%b B=%b C=%b D=%b Y=%b",a,b,c,d,out);

a=1;b=2;c=3458578;d=4; s1 = 1; s0 = 0;
#10;
$display("A=%b B=%b C=%b D=%b Y=%b",a,b,c,d,out);

a=1;b=2;c=3;d=4; s1 = 1; s0 = 1;
#10;
$display("A=%b B=%b C=%b D=%b Y=%b",a,b,c,d,out);
end
endmodule