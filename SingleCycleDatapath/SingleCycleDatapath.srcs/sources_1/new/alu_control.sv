module alu_control (
    input  logic [1:0] alu_op,      
    input  logic [6:0] func7,       
    input  logic [2:0] func3,        
    output logic [3:0] alu_ctrl    
);

    always_comb begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010; 
            2'b01: alu_ctrl = 4'b0110; 
            2'b10: begin               
                if (func7 == 7'b0000000 && func3 == 3'b000)
                    alu_ctrl = 4'b0010; 
                else if (func7 == 7'b0100000 && func3 == 3'b000)
                    alu_ctrl = 4'b0110; 
                else if (func7 == 7'b0000000 && func3 == 3'b111)
                    alu_ctrl = 4'b0000; 
                else if (func7 == 7'b0000000 && func3 == 3'b110)
                    alu_ctrl = 4'b0001;
                else
                    alu_ctrl = 4'b0000;
            end
            2'b11: begin              
                if (func3 == 3'b000)
                    alu_ctrl = 4'b0010; 
                else if (func3 == 3'b111)
                    alu_ctrl = 4'b0000; 
                else if (func3 == 3'b110)
                    alu_ctrl = 4'b0001;
                else
                    alu_ctrl = 4'b0000;
            end
            default: alu_ctrl = 4'b0000;
        endcase
    end
endmodule