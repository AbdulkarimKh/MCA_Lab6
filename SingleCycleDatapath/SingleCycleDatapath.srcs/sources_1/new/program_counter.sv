module program_counter#( parameter n = 32)(
    
    input logic clk,
    input logic reset_n,
    input logic [n - 1: 0] data_in,
    output logic [n - 1: 0] data_o
    
    );
    
    always_ff @(posedge clk, negedge reset_n) begin 
        if(reset_n) data_o <= 32'b0;
        else begin 
            data_o <= data_in;
        end
    end
endmodule
