module RegisterFile (
    input wire clk,
    input wire rst,
    input wire [7:0] enable,
    input wire [7:0] address1,
    input wire [7:0] address2,
    input wire [7:0] addressData,
    input wire [7:0] dataIn,

    output reg [7:0] data1,
    output reg [7:0] data2
);    
    reg [7:0] registers [7:0];

    always @(posedge clk, negedge rst) begin
        if (rst) begin
            for (integer i = 0; i<= 8; i++)
                registers[i] <= 8'd0;
        end
        else begin
            data1 <= registers[address1];
            data2 <= registers[address2];

            if (enable)
                registers[dataIn] <= dataIn;
        end
    end

endmodule