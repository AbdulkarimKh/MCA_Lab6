module data_mem#( 
    N = 32
)(
    input clk, reset_n, mem_write, mem_read,
    input [N-1:0] addr, wdata,
    output logic [N-1:0] rdata
);

    logic [N-1:0] dmem [0:1023];

    always_ff @(posedge clk or negedge reset_n) begin 
        if (!reset_n) begin
            for (int i = 0; i < 1024; i++) begin
                dmem[i] <= 0;
            end
        end else if (mem_write) begin
            if (addr[1:0] == 2'b00) begin
                dmem[addr[31:2]] <= wdata;
            end
        end
    end
    
    always_comb begin
        if (mem_read && addr[1:0] == 2'b00) begin
            rdata = dmem[addr[31:2]];
        end else begin
            rdata = 32'b0;
        end
    end
endmodule
