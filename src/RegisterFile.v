module RegisterFile (
    input   wire            clk,
    input   wire            rst,
    input   wire            enable,
    input   wire    [2:0]   address1,
    input   wire    [2:0]   address2,
    input   wire    [2:0]   addressData,
    input   wire    [7:0]   dataIn,

    output  reg     [7:0]   data1,
    output  reg     [7:0]   data2,
    output  reg     [7:0]   dataMemory
);    
    reg [2:0]   registers   [7:0];

    always @(posedge clk, negedge rst) begin
        if (rst) begin
            for (integer i = 0; i<= 8; i++)
                registers[i] <= 8'd0;
        end
        else begin
            data1 <= registers[address1];
            data2 <= registers[address2];
            dataMemory <= registers[addressData];

            if (enable)
                registers[addressData] <= dataIn;
        end
    end

endmodule