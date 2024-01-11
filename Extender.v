module Extender (
    input   wire    [5:0]   imm,

    output  reg     [7:0]   extended
);
    reg [7:0] temp;

    always @(*) begin
        temp[7:2] = imm;
        
        extended = temp;
    end
    
endmodule