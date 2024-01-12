module ProgramCounter (
    input   wire            clk,
    input   wire            rst,
    input   wire    [7:0]   next,

    output  reg     [7:0]   current
);
    always @(posedge clk, negedge rst) begin
        if (rst) begin
            current <= 8'd0;
        end
        else begin
            current <= next;
        end
    end

endmodule