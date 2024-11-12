// module fp_add(input [31:0] a, b, output [31:0] sum);

//     // Extracting components of input floats
//     //wire sign_a = a[31];
//     //wire sign_b = b[31];
//     wire [7:0] exp_a = a[30:23];
//     wire [7:0] exp_b = b[30:23];
//     wire [22:0] mant_a = a[22:0];
//     wire [22:0] mant_b = b[22:0];

//     // Comparing exponents to determine the larger exponent
//     wire [7:0] bigger_exp = (exp_a > exp_b) ? exp_a : exp_b;

//     // Normalizing mantissa of smaller exponent
//     wire [23:0] norm_mant_a; //= (exp_a > exp_b) ? {1'b1, mant_a} : {1'b1, mant_a}>> (exp_b - exp_a) ;
//     wire [23:0] norm_mant_b; //= (exp_a > exp_b) ? {1'b1, mant_b} >> (exp_a - exp_b) : {1'b1, mant_b};
//     wire [24:0] sum_mant; //= {1'b0,norm_mant_a} + {1'b0,norm_mant_b};

//     assign norm_mant_a = (exp_a > exp_b) ? {1'b1, mant_a} : {1'b1, mant_a}>> (exp_b - exp_a) ;
//     assign norm_mant_b = (exp_a > exp_b) ? {1'b1, mant_b} >> (exp_a - exp_b) : {1'b1, mant_b};
//     assign sum_mant = {1'b0,norm_mant_a} + {1'b0,norm_mant_b};
//     // Checking for overflow and normalizing result
//     wire [22:0] final_mant;
//     wire [7:0] final_exp;
//     //wire final_sign;
//     wire [23:0] temp;


//     if (sum_mant[24] == 1'b1) begin
//         assign final_mant = sum_mant[23:1];
//         assign final_exp = bigger_exp + 1;
//     end 
//     else if(sum_mant[23] == 1) begin
//         assign final_mant = sum_mant[22:0];
//         assign final_exp = bigger_exp;
//     end 
//     else if(sum_mant[22] == 1) begin
//         assign temp = sum_mant[23:0] << 1;
//         assign final_mant = temp[22:0];
//         assign final_exp = bigger_exp - 1'b1;
//     end 
//     else if(sum_mant[21] == 1) begin
//         assign temp = sum_mant[23:0] << 2;
//         assign final_mant = temp[22:0];
//         assign final_exp = bigger_exp - 2;
//     end

    

//     // Assembling final result
//     assign sum = {1'b1, final_exp, final_mant};

// endmodule


module fp_add(input [31:0] a, b, output reg [31:0] y);

    // Extracting components of input floats
    //wire sign_a = a[31];
    //wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [22:0] mant_a = a[22:0];
    wire [22:0] mant_b = b[22:0];
    reg [7:0] bigger_exp;
    reg [23:0] norm_mant_a; //= (exp_a > exp_b) ? {1'b1, mant_a} : {1'b1, mant_a}>> (exp_b - exp_a) ;
    reg [23:0] norm_mant_b; //= (exp_a > exp_b) ? {1'b1, mant_b} >> (exp_a - exp_b) : {1'b1, mant_b};
    reg [24:0] sum_mant;

    reg [22:0] final_mant;
    reg [7:0] final_exp;
    //wire final_sign;
    reg [23:0] temp;

    always @* begin
        bigger_exp = (exp_a > exp_b) ? exp_a : exp_b;
        norm_mant_a = (exp_a > exp_b) ? {1'b1, mant_a} : {1'b1, mant_a}>> (exp_b - exp_a) ;
        norm_mant_b = (exp_a > exp_b) ? {1'b1, mant_b} >> (exp_a - exp_b) : {1'b1, mant_b};
        sum_mant = {1'b0,norm_mant_a} + {1'b0,norm_mant_b};

        if (sum_mant[24] == 1'b1) begin
            final_mant = sum_mant[23:1];
            final_exp = bigger_exp + 1;
        end 
        else if(sum_mant[23] == 1) begin
            final_mant = sum_mant[22:0];
            final_exp = bigger_exp;
        end 
        else if(sum_mant[22] == 1) begin
            temp = sum_mant[23:0] << 1;
            final_mant = temp[22:0];
            final_exp = bigger_exp - 1'b1;
        end 
        else if(sum_mant[21] == 1) begin
            temp = sum_mant[23:0] << 2;
            final_mant = temp[22:0];
            final_exp = bigger_exp - 2;
        end

        y = {1'b0, final_exp, final_mant};

    end


endmodule

// module test;
//     reg [31:0] a,b;
//     wire [31:0] y;

//     fp_add f1(a,b,y);

//     initial begin
//         a = 32'b01111010010000000000000000000000;
//         b = 32'b01111010010000000000000000000000;
//         #10;
//         $display("a=%b b=%b y=%b",a,b,y);
//         $finish;
//     end
// endmodule

module veda_m(
    input clk,
    //input rst,
    input mode,
    input [4:0] address_a,
    input [4:0] address_b,
    input write_enable,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    reg [31:0] mem [31:0];

    always @ (posedge clk) begin
        if (mode == 0 &&  write_enable==1) begin
            mem[address_a] = data_in;
            data_out = data_in;
        end 
        else if(mode == 1 &&  write_enable==1) begin
            data_out = mem[address_b];
            mem[address_b] = data_in;
        end
        else if(write_enable==0) begin
            data_out = mem[address_b];
            //mem[address_b] = data_in;
        end

        
    end
endmodule

// module test();
//     reg [31:0] a,b;
//     wire [31:0] y;

//     fp_add f1(a,b,y);

//     initial begin
//         a = 32'b01111010010000000000000000000000;
//         b = 32'b01111010010000000000000000000000;
//         #10;
//         $display("a=%b b=%b y=%b",a,b,y);
//         $finish;
//     end
// endmodule

module final_mo(input clk,output reg p);
reg [31:0]data_in;
reg [4:0] ram_address_a;
reg [4:0] ram_address_b;
reg write_enable;
//reg clk;
reg mode;
wire [31:0]data_out;

reg [31:0] a,b,c;
wire [31:0] y;
fp_add f1(a,b,y);
veda_m ram1( clk,mode, ram_address_a,ram_address_b,write_enable,data_in,data_out);
// initial
//  begin
//     $dumpfile("test.vcd");
//     $dumpvars(0,testbench);
//  end
// initial begin // clock initialization
// clk =1'b0;
// forever #5 clk=~clk;
// end

initial begin
// writing data into the memory
write_enable =1'b1;
mode = 1'b0;
//#20;
ram_address_a=5'd0;
data_in = 32'b01000001110100000000000000000000;
#10 write_enable =1'b0;
#5;

ram_address_a=5'd1;
data_in = 32'b01000010011100000000000000000000;
write_enable =1'b1;
#10 write_enable =1'b0;
#10;

ram_address_a=5'd2;
data_in = 32'b01000010101011000000000000000000;
write_enable =1'b1;

#10;

//reading data from the memory
write_enable =1'b0;
ram_address_b=5'd0;
#10 a = data_out;
#10;
ram_address_b=5'd1;
#10 b = data_out;
#10;
ram_address_b=5'd2;
#10 c = data_out;
#10;
// $finish;
end
always @(*) begin
    p = (c==y) ? 1: 0;
end
endmodule

module test;
reg clk;
wire p;

final_mo w1(clk,p);
initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,test);
end

initial begin // clock initialization
clk =1'b0;
forever #5 clk=~clk;
end

initial begin
    #250;
    $display("p = %b",p);
    #200 $finish;
end

endmodule