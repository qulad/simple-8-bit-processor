module Extender (
    input   wire    [5:0]   imm,
    input   wire    [7:0]   addr,
    input   wire            control,
    input   wire            beq,

    output  reg     [7:0]   extendedControl0,
    output  reg     [7:0]   extendedControl1
);
    reg [7:0]   temp;

    always @(*) begin
        if (control) begin
            temp[7:2] <= imm;

            extendedControl1 <= temp;
        end
        else begin
            if (beq)
                extendedControl1 <= addr;
            else begin
                temp[7:2] <= imm;

                extendedControl0 <= temp;
            end
        end
    end

endmodule