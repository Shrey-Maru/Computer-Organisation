module ALU (input[31:0] instruction,a,b, input rtype,itype,jtype, output reg [31:0] c, output reg branch);
    reg [5:0] opcode,func;
    reg [4:0] rs,rt,rd,shamt;
    reg [31:0] const;

    always @(*) begin
        func = instruction[5:0];
        opcode = instruction[31:26];
        if(rtype) begin
            // rs = instruction[25:21];
            // rt = instruction[20:16];
            // rd = instruction[15:11];
            case (func)
                6'b100000: c = a + b;  //add
                6'b100010: c = a - b;  //sub
                6'b100001: c = a + b;  //addu
                6'b100011: c = a - b;  //subu
                6'b100100: c = a & b;  //and
                6'b100101: c = a | b;  //or
                6'b000000: begin       // sll
                    shamt = instruction[10:6];
                    c = a << shamt;
                end
                6'b000010: begin       //srl
                    shamt = instruction[10:6];
                    c = a >> shamt;
                end
                6'b101010: c = (a<b) ? 1 : 0;  //slt
                


                default: c = 0;
            endcase

        end

        else if(itype) begin
            const[31:0] = { {16{1'b0}} ,instruction[15:0] };
            
            case (opcode)
                6'b001000: c = a + const;  //addi
                6'b001001: c = a + const;  //addiu
                //6'b001100: c = a & const;  //andi
                //6'b001101: c = a | const;  //ori
                
                6'b101010: c = (a<const) ? 1 : 0; //slti
                default: c = 0;
            endcase


        end

        if(jtype) begin
            
            case (opcode)
                6'b000101: branch = (a!=b)?1:0;  //bne
                6'b000100: branch = (a==b)?1:0;  //beq

                6'b000111: begin
                    if(a >= b) branch = 1;
                    else branch = 0;
                end//branch = (a>b)?1:0;  //bgt

                //6'b001101: branch = (a>=b)?1:0;  //bgte

                6'b000110: branch = (a<b) ? 1:0;  //ble

                //6'b001101: branch = (a<=b)?1:0;  //bleq
                
                6'b111111: branch = 1;  //j 
                6'b111110: branch = 1;  //jr
                6'b111101: branch = 1;  //jal

                //default: branch=0;
            endcase
        end


    end
endmodule