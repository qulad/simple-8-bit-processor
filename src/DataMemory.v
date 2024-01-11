module DataMemory(
    input   wire            clk,
    input   wire            rst,
    input   wire            enable,
    input   wire    [7:0]   address,
    input   wire    [7:0]   dataInput,

    output  reg     [15:0]  dataOutput
);
    reg [15:0]  memory  [32:0];

    always @(posedge clk or posedge rst) begin
        if (rst)
            for (integer i = 0; i < 8; i = i + 1)
                memory[i] <= 15'd0;
        else begin
            if (enable)
                mem[address] <= dataInput;
            else
                dataOutput <= mem[dataInput];
        end
    end

endmodule