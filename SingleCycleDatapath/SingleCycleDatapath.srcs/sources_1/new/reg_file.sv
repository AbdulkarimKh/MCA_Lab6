module reg_file#( 
        N =32)
    (
        input clk, reset_n, reg_write,
        input [4:0] raddr1,raddr2,waddr,
        input [N-1:0] wdata,
        output logic [N-1:0] rdata1, rdata2
        
    );
        logic [N-1:0] reg_array [N-1:0];
    always_ff @(posedge clk, negedge reset_n) begin 
        if(reset_n) 
            for(int i = 0; i < N; i++) begin
            reg_array[i] <= 0;
            end
            else if (reg_write && waddr != 5'b0) begin
            reg_array[waddr] <= wdata;
            end 
        end
        
        always_comb begin
            rdata1 = reg_array[raddr1];
            rdata2 = reg_array[raddr2];
        
        end
        assign reg_array[0] = 32'b0;
endmodule
