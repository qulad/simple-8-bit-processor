module Alu(
    input   wire    [7:0]   inputA,
    input   wire    [7:0]   inputB,
    input   wire    [1:0]   control, // [0] -> +, [1] -> -, [2] -> &, [3] -> |,

    output  reg     [7:0]   result,
    output  reg             zero
);
    always @(*) begin
        case(control)
            2'b00: begin // +
                    result <= inputA + inputB;

                    if (result == 0)
                        zero <= 1;
            end
            2'b01: begin // -
                    result <= inputA - inputB;

                    if (result == 0)
                        zero <= 1;
            end
            2'b10: begin // &
                    result <= inputA & inputB;

                    if (result == 0)
                        zero <= 1;
            end
            2'b11: begin // |
                    result <= inputA | inputB;

                    if (result == 0)
                        zero <= 1;
                end
        endcase
    end

endmodule