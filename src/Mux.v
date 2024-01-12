module Mux (
    input   wire    [7:0]   inputControl0,
    input   wire    [7:0]   inputControl1,
    input   wire            control,

    output  reg     [7:0]   muxed
);
    always @(*) begin
        if (control) begin
            muxed <= inputControl1;
        end
        else begin
            muxed <= inputControl0;
        end
    end

endmodule