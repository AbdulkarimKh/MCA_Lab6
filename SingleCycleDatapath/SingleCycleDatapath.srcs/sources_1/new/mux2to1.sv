module mux_2to1 #(
    parameter N = 32
)(
    input logic [N-1:0] input0, 
    input logic [N-1:0] input1,  
    input logic sel,                
    output logic [N-1:0] outMUX     
);

    assign outMUX = (sel) ? input1 : input0;

endmodule
