module data_path_top#(
    N =32)(
    input clk,
    input reset_n
    );
    
   logic [31:0] current_pc, next_pc;
   wire [N-1:0] outPC, outIM, outIMM,outPC4,outPC_IMM;
   logic Reg_write,zero, alu_src, mem_read, mem_write, mem_to_reg, branch, PCSrc;
   wire [1:0] alu_op;
   logic [4:0] rs1, rs2, rd;
    wire [3:0] alu_ctrl;
    assign rs1 = outIM[19:15];  
    assign rs2 = outIM[24:20];  
    assign rd  = outIM[11:7]; 
    
    logic [N-1:0] rdata1, rdata2,outMUX1,outMUX2,ALUResult, outDMEM;
   program_counter#(
   .N(N)
   ) PC (
     .clk(clk),
    .reset_n(reset_n),
    .data_in(next_pc),
    .data_o(outPC)
   );
   
   inst_mem#(
    .N(N)
    )instM(
        .addr(outPC),
        .inst(outIM)
   );
   
   reg_file#(
   .N(N)
   )RegFile(
    .clk(clk),
    .reset_n(reset_n),
    .Reg_write(Reg_write),
    .raddr1(rs1),
    .raddr2(rs2),
    .waddr(rd),
    .wdata(outMUX2),
    .rdata1(rdata1),
    .rdata2(rdata2)
   );
   
   mux2to1#(
    .N(N)
    )MUX1(
    .input0(rdata2),
    .input1(outIM),
    .sel(alu_src),
    .outMUX(outMUX1)
    );
    
    alu_ctrl#(
    .N(N)
    ) ALU1(
    .op1(rdata1),
    .op2(outMUX1),
    .alu_ctrl(alu_ctrl),
    .alu_result(ALUResult),
    .zero(zero)
    );
    
    data_mem#(
    .N(N)
    )data_mem(
    .clk(clk),
    .reset_n(reset_n),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .addr(ALUResult),
    .wdata(rdata2),
    .rdata(outDMEM)
    );
    
    imm_gen#(
    .N(N)
    )inn_gen(
    .inst(outIM),
    .imm(outIMM)
    );
    
    mux2to1#(
    .N(N)
    )MUX2(
    .input0(ALUResult),
    .input1(outDMEM),
    .sel(mem_to_reg),
    .outMUX(outMUX2)
    );
    
    alu_ctrl#(.N(N)) ALU_PC_4 (
        .op1(outPC),
        .op2(32'd4),
        .alu_ctrl(4'b0000),
        .alu_result(outPC4)
    );
    
    alu_ctrl#(.N(N)) ALU_PC_imm (
        .op1(outPC),
        .op2(outIMM),
        .alu_ctrl(4'b0000),
        .alu_result(outPC_IMM)
    );
    
    main_control main_control (
        .opcode(outIM[6:0]),
        .reg_write(Reg_write),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch)
    );

    alu_control alu_ctrl1(
        .alu_op(alu_op),
        .func7(outIM[31:25]),
        .func3(outIM[14:12]),
        .alu_ctrl(alu_ctrl)
    );
    and(PCSrc,branch,zero);
    
    mux2to1#(
        .N(N)
         )MUX3(
         .input0(outPC4),
        .input1(outPC_IMM),
         .sel(PCSrc),
         .outMUX(next_pc)
    );
endmodule