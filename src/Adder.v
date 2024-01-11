module Alu(
    input   wire    [7:0]   input8,
    input   wire    [15:0]  input16,

    output  reg     [15:0]  result,
);
    reg [15:0]  temp;

    always @(*) begin
        temp[15:8] = input8;

        result <= input16 + temp;
    end

endmodule