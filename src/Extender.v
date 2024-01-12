module Extender (
    input   wire    [5:0]   imm,
    input   wire    [7:0]   addr,
    input   wire            control,
    input   wire            beq,

    output  reg     [7:0]   extendedControl0,
    output  reg     [15:0]  extendedControl1
);
    reg [7:0]   temp8;
    reg [15:0]  temp15;

    always @(*) begin
        if (control) begin
            temp15[15:10] <= imm;

            extendedControl1 <= temp15;
        end
        else begin
            if (beq) begin
                temp15[15:8] <= addr;

                extendedControl1 <= temp15;
            end
            else begin
                temp15[7:2] <= imm;

                extendedControl0 <= temp15;
            end
        end
    end

endmodule