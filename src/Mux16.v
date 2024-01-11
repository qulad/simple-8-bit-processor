module Mux16 (
    input   wire    [15:0]  inputControl0,
    input   wire    [15:0]  inputControl1,
    input   wire            control,

    output  reg     [15:0]  muxed
);
    always @(*) begin
        if (control) begin
            muxed = inputControl1;
        end
        else begin
            muxed = inputControl0;
        end
    end

endmodule