module alu_ctrl#(
    N =32)
    ( 
        input [N-1:0] op1,op2,
        input [3:0] alu_ctrl,
        output logic [N-1:0] alu_result,
        output logic zero
    );
    
    logic [N-1:0] result;
    always_comb begin
    case (alu_ctrl)
    4'b0000: result = op1 + op2;
    4'b1000: result = op1 - op2;
    4'b0111: result = op1 & op2;
    4'b0110: result = op1 | op2;
    4'b0100: result = op1 ^ op2;
    4'b0001: result = op1 << op2[4:0];
    4'b0101: result = op1 >> op2;
    4'b1101: result = $unsigned(op1) >>> op2[4:0];
    4'b0010: result = (op1 < op2) ? 32'b1:32'b0;
    4'b0011: result = ($unsigned(op1) < $unsigned(op2)) ? 32'b1:32'b0;
    default: result = 32'b0;
    endcase
    
    zero =(result == 32'b0);
    end
endmodule
