module inst_mem#( N=32 )
    (
    input [N-1:0] addr,
    output [N-1:0] inst
    
    );
    logic [31:0] imem [0:255];
    initial begin
    $readmemh("machine.hex", imem);
    end
endmodule
