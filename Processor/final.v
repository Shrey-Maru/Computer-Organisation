`include "decoder.v"
`include "alu.v"

module mux_2to1(
  input sel,
  input [31:0]in0,
  input [31:0]in1,
  output reg [31:0]out
);

  always @(*) begin
    if (sel == 1'b0) begin
      out = in0;
    end else begin
      out = in1;
    end
  end
  
endmodule

module mux2_2to1(
  input sel,
  input [4:0]in0,
  input [4:0]in1,
  output reg [4:0]out
);

  always @(*) begin
    if (sel == 1'b0) begin
      out = in0;
    end else begin
      out = in1;
    end
  end
  
endmodule

module veda_m(
    input clk,
    input mode,
    input [7:0] address_a,
    input [7:0] address_b,
    input write_enable,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    reg [31:0] mem [31:0];
    // Machine Code for Bubble Sort 
    initial begin
        mem[0] = 32'b00100000000000110000000000000001; //addi r3,r0,1
        mem[1] = 32'b00100000000000010000000000000000; //addi r3,r0,1 
        mem[2] = 32'b00010000100000000000000000001110; //beq r4,r0,end(17)
        mem[3] = 32'b00000000010011110001000000100010; //sub r2,r2,r15
        mem[4] = 32'b00100000000001000000000000000000; //addi r4,r0,0
        mem[5] = 32'b00011100010000110000000000000001; //bgt r2,r3,continue(7)
        mem[6] = 32'b11111100000000000000000000000000; //j outerloop(0)
        mem[7] = 32'b10001100001001010000000000000000; //lw r5,0(r1)
        mem[8] = 32'b10001100001001100000000000000001; //lw r6,1(r1)
        mem[9] = 32'b00011000101001100000000000000100; //ble r5,r6,skipswap(14)
        mem[11] = 32'b10101100001001010000000000000001; //sw r5, 1(r1)
        mem[10]= 32'b10101100001001100000000000000000; //sw r6, 0(r1)
        mem[12]= 32'b00100000000010110000000000000001;
        mem[13]= 32'b00100000000001000000000000000001; //addi r4,r0,1
        mem[14]= 32'b00100000001000010000000000000001; //addi r1,r1,1
        mem[15]= 32'b00100000011000110000000000000001; //addi r3,r3,1
        mem[16]= 32'b11111100000000000000000000000101; //j innerloop(4)
        // mem[15]= 32'b00000000000000000000000000000000; //end
        mem[17] = 32'b10001100000001110000000000000000; //lw r7,0(r0)
        mem[18] = 32'b10001100000010000000000000000001; //lw r8,1(r0)
        mem[19] = 32'b10001100000010010000000000000010; //lw r9,2(r0)
        mem[20] = 32'b10001100000010100000000000000011; //lw r10,3(r0)
        

       


        
        

        

    end
    always @ (*) begin
        // if (mode == 0 &&  write_enable==1) begin
        //     mem[address_a] = data_in;
        //     data_out = data_in;
        // end 
        // else if(mode == 1 &&  write_enable==1) begin
        //     data_out = mem[address_b];
        //     mem[address_b] = data_in;
        // end
        // else if(write_enable==0) begin
        //     data_out = mem[address_b];
        //     //mem[address_b] = data_in;
        // end
        // mem[address_a] = data_in;

        data_out = mem[address_b];

        
    end
endmodule

module veda_m2(
    input clk,
    input mode,
    input [7:0] address_a,
    input [7:0] address_b,
    input write_enable,
    input [31:0] data_in,
    output [31:0] data_out
);
    reg [31:0] mem [31:0];
    initial begin
        
     

        mem[0] = 32'b00000000000000000000000000000010; //2
        mem[1] = 32'b00000000000000000000000000000100; //4
        mem[2] = 32'b00000000000000000000000000000000; //0

  
        

    end
    always @ (posedge clk) begin
        // if (mode == 0 &&  write_enable==1) begin
        //     mem[address_a] = data_in;
        //     data_out = data_in;
        // end 
        // else if(mode == 1 &&  write_enable==1) begin
        //     data_out = mem[address_b];
        //     mem[address_b] = data_in;
        // end
        if(write_enable) begin
            // data_out = mem[address_b];
            mem[address_a] = data_in;
        end
        // mem[address_a] <= data_in;

        //data_out <= mem[address_b];

    end

    assign data_out = (write_enable) ? 0 :mem[address_b];
endmodule

module bubble(input clk, output reg[31:0] c);
    wire mode,write_enable;
    reg [7:0] address_a;
    wire [7:0] address_b,address_b2;
    wire [31:0] data_in,data_out,data_out2;
    wire [31:0] data_in2;
    wire [7:0]  address_a2;
    wire [31:0] a;
    wire [31:0] b;
    // reg [5:0] opcode,func;
    wire [4:0] rs,rt,rd,shamt;

    wire R,I,J; 
    wire branch;
    wire[31:0] out;
    reg [5:0] opcode;
    reg [7:0] jumpadd;

    veda_m Instruc(clk,mode,address_a,address_b,write_enable,data_in,data_out);

    veda_m2 Data(clk,mode,address_a2,address_b2,write_enable,data_in2,data_out2);

    mips_decoder m1(data_out,R,I,J);
    ALU a1(data_out,a,b,R,I,J,out,branch);

    reg [31:0] r [31:0];
    reg [31:0] IR;
    reg [7:0] PC=0;

    reg flag_ins_ex=0;
    initial begin
        r[0] = 32'b00000000000000000000000000000000;
        r[1] = 32'b00000000000000000000000000000000;
        r[2] = 32'b00000000000000000000000000000011;
        r[3] = 32'b00000000000000000000000000000000;
        r[4] = 32'b00000000000000000000000000000001;
        r[5] = 32'b00000000000000000000000000000000;
        r[6] = 32'b00000000000000000000000000000000;
        r[15]= 32'b00000000000000000000000000000001;
    end

    assign a = r[data_out[25:21]];
    assign b1 = r[data_out[20:16]];
    //assign b2 = {{16{1'b0}},data_out[15:0]};
    assign b2 = ((data_out[31:26]==6'b000110) || (data_out[31:26]==6'b000111) || (data_out[31:26]==6'b000100)) ? (b1) : {{16{1'b0}},data_out[15:0]};
    wire [31:0] b1,b2;
    mux_2to1 mux1(R,b2,b1,b);

    //assign r[data_out[15:11]] <= out;
    wire [4:0] d1,d2;

    assign d1 = data_out[15:11];
    assign d2 = data_out[20:16];

    mux2_2to1 mux2(R,d2,d1,rd);

    
    assign address_b = PC;     //instruction fetch

    assign address_b2 =  (data_out[31:26]==6'b001000)? 0 : r[data_out[25:21]] + data_out[15:0];

    assign address_a2 = (data_out[31:26]==6'b101011) ? (r[data_out[25:21]] + data_out[15:0]) : 30;

    assign data_in2 = r[rd];
    assign write_enable = (data_out[31:26]==6'b101011) ? 1 : 0;

    always @(posedge clk) begin
        // address_b = PC;
        IR <= data_out;
        //r[rd] = out;
        if((data_out[31:26]!=6'b000110) && (data_out[31:26]!=6'b000111)) r[rd]=out;
        if(data_out[31:26]==6'b001000) r[rd] = out;
       

        case (data_out[31:26])
            6'b100011: begin  //lw r0, 10(r1)
                //address_b2 = r[data_out[25:21]] + data_out[15:0];
                r[rd]= data_out2;

                PC = PC + 1;
            end

            6'b101011: begin  //sw r0, 10(r1)
                //address_a2 = r[data_out[25:21]] + data_out[15:0];
                // data_in2 = r[rd];

                PC = PC + 1;
            end

            6'b111111: PC <= data_out[7:0];  //j 10

            6'b111110: begin
                jumpadd <= r[IR[4:0]]; //j r0
                PC <= jumpadd[7:0];
            end

            6'b111101: begin
                //jal 10
                r[31] <= PC + 1 ;
                PC <= IR[7:0];
            end

            6'b000101: PC <= PC + 1 + data_out[7:0]; //bne
            6'b000100: begin
              if(branch) PC <= PC + 1 + data_out[7:0];  //beq
              else PC <= PC + 1;
            end
            6'b000111: begin
              if(branch) PC <= PC + 1 + data_out[7:0];  //PC <= PC + 1 + IR[7:0];  //bgt
              else PC <= PC + 1;
            end
            //6'b001101: PC <= PC + 1 + IR[7:0];  //bgte
            6'b000110: begin
              if(branch) PC <= PC + 1 + data_out[7:0];  //PC <= PC + 1 + IR[7:0];  //ble
              else PC <= PC + 1;
            end
            //6'b001101: PC <= PC + 1 + IR[7:0];  //bleq
            //default: PC = PC + 1 + IR[7:0]; 
            default: PC <= PC + 1;
        endcase

    end





    






    
endmodule


