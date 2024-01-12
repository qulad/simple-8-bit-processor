module Adder(
    input   wire    [7:0]   inputAdd,
    input   wire    [7:0]   inputInstruction,

    output  reg     [7:0]  result
);
    always @(*) begin
        result <= inputInstruction + inputAdd;
    end

endmodule