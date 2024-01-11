module Extender (
    input   wire    [5:0]   imm,
    input   wire            control,

    output  reg     [7:0]   extendedControl0,
    output  reg     [15:0]  extendedControl1
);
    reg [7:0] temp8;
    reg [15:0] temp15;

    always @(*) begin
        if (control) begin
            temp15[15:10] = imm;

            extendedControl1 = temp15;
        end
        else begin
            temp[7:2] = imm;
        
            extendedControl0 = temp;
        end
    end
    
endmodule