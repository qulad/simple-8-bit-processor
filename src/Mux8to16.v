module Mux8to16 (
    input   wire    [8:0]   inputControl0,
    input   wire    [8:0]   inputControl1,
    input   wire            control,

    output  reg     [15:0]  muxed
);
    reg [15:0]  temp;

    always @(*) begin
        if (control) begin
            temp[15:7] = inputControl1
        end
        else begin
            temp[15:7] = inputControl0;
        end
        muxed = temp;
    end
    
endmodule