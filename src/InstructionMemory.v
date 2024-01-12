module InstructionMemory(
    input   wire            clk,
    input   wire    [7:0]  address,

    output  reg     [15:0]  dataOutput
);
    reg [7:0]  memory  [32:0];

    always @(posedge clk or posedge rst) begin
        dataOutput <= mem[dataInput];
    end

endmodule