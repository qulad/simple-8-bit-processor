module ProgramCounter (
    input   wire            clk,
    input   wire            rst,
    input   wire    [15:0]  next,

    output  reg     [15:0]  current
);

    always @(posedge clk, negedge rst) begin
        if (rst) begin
            current = 15'd0;
        end
        else begin
            current = next;
        end
    end
    
endmodule