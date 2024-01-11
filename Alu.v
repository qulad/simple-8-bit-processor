module Alu(
    input   wire    [7:0]   inputA,
    input   wire    [7:0]   inputB,
    input   wire    [1:0]   control, // [0] -> +, [1] -> -, [2] -> &, [3] -> |,

    output  reg     [7:0]   result,
    output  reg     [2:0]   aluFlags // [0]Negative, [1]Zero, [2]oVerflow, [3]Carry
);
    always @(*) begin
        case(control)
            2'b00: begin // +
                    result <= inputA + inputB;

                    aluFlags <= 2'b00;
                    if (result == 0)
                        aluFlags[1] <= 1;  // Zero
                    else if (result[31] == 1)
                        aluFlags[0] <= 1;  // Negatif
                    aluFlags[3] <= (result < inputA) | (result < inputB); // Carry
                    aluFlags[2] <= (inputA[31] ^ inputB[31]) & (result[31] ^ inputA[31]); // oVerflow
                end
            2'b01: begin // -
                    result <= inputA - inputB;

                    aluFlags <= 4'b00;
                    if (result == 0)
                        aluFlags[1] <= 1; // Zero
                    else if (result[31] == 1)
                        aluFlags[0] <= 1; // Negatif
                    aluFlags[3] <= (inputA < inputB); // Carry
                    aluFlags[2] <= (inputA[31] ^ inputB[31]) & (result[31] ^ inputA[31]); // oVerflow
                end
            2'b10: begin // &
                    result <= inputA & inputB;

                    aluFlags <= 4'b00;
                    if (result == 0)
                        aluFlags[1] <= 1; // Zero
            2'b11: begin // |
                    result <= inputA | inputB;

                    aluFlags <= 4'b00;
                    if (result == 0)
                        aluFlags[1] <= 1; // Zero
                end
            end
        endcase
    end
endmodule