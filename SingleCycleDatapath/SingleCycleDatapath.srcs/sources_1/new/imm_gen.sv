module imm_gen#( 
    N=32)
    (
        input [N-1:0] inst,
        output logic [N-1:0] imm
    );
    
    always_comb begin
        imm=32'b0;
        case(inst[6:0])
            7'b0010011: begin  //I
                imm = {{20{inst[31]}}, inst [31:20]};
         end
            7'b0000011: begin //I*
              imm = {{27{inst[31]}}, inst[24:20]};
         end
            7'b0100011: begin //S
              imm = {{20{inst[31]}}, inst [31:25], inst [11:7]};
         end
            7'b0010111: begin //U
                imm = {inst[31:12], 12'b0};         end
            7'b1100011: begin //B
              imm = {{19{inst[31]}}, inst [31], inst [7], inst[30:25], inst [11:8],1'b0};
         end
            7'b1101111: begin //J
              imm = {{11{inst[31]}},inst[31], inst [19:12], inst [20], inst[30:21],1'b0};
         end
        endcase
    end
endmodule
