module DataMemory(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire [7:0] address,
    input wire [7:0] dataInput,
    output reg [7:0] dataOutput
);

    reg [7:0] memory [7:0]; // Bellek tanımı, 32 adres alanı için

    always @(posedge clk or posedge rst) begin
        if (rst)
            for (integer i = 0; i < 8; i = i + 1)
                memory[i] <= 7'd0; // Belleği sıfırlama
        else begin
            if (enable) // Belleğe yazma
                mem[address] <= dataInput;
            else // Bellekten okuma
                dataOutput <= mem[dataInput];
        end
    end

endmodule