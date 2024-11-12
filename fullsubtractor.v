module full_sub(a,b,bin,diff,bout);
input a,b,bin;
output diff,bout;

wire a_comp, b_comp;
wire x1,x1_comp;
wire x2,x3;
not(a_comp,a);
not(b_comp,b);

xor(x1,a,b);
not(x1_comp,x1);

and(x2,a_comp,b);
and(x3,x1_comp,bin);
or(bout,x2,x3);

xor(diff,x1,bin);

endmodule

module tb();
reg a,b,bin;
wire d,bout;
full_sub s1(a,b,bin,d,bout);
initial begin
    a=0;b=0;bin=0;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=0;b=0;bin=1;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=0;b=1;bin=0;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=0;b=1;bin=1;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=1;b=0;bin=0;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=1;b=0;bin=1;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=1;b=1;bin=0;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);

    a=1;b=1;bin=1;
    #10
    $display("%b %b %b %b %b",a,b,bin,d,bout);
end
endmodule