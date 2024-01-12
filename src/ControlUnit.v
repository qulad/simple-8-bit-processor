module ControlUnit (
    input   wire            clk,
    input   wire            rst,
    input   wire    [15:0]  instruction,
    input   wire            zero,

    output  reg     [2:0]   address1,
    output  reg     [2:0]   address2,
    output  reg     [2:0]   addressData,

    output  reg     [5:0]   imm,
    output  reg     [7:0]   addr,

    output  reg     [1:0]   alu,
    output  reg             mux8,
    output  reg             mux8to16,
    output  reg             registerFileEnable,
    output  reg             extenderControl,
    output  reg             mux16A,
    output  reg             mux16B,
    output  reg             dataMemoryEnable,
    output  reg             beq
);
    reg [3:0]   opcode;
    reg [2:0]   func;

    always @(posedge clk, negedge rst) begin
        if (rst) begin
            alu <= 2'b00;
            mux8 <= 0;
            mux8to16 <= 0;
            registerFileEnable <= 0;
            extenderControl <= 0;
            mux16A <= 0;
            mux16B <= 0;
            dataMemoryEnable <= 0;
            beq <= 0;
        end
        else begin
            opcode <= instruction[15:12];

            case(opcode)
                4'b0000: begin // add, sub, and, or
                    func <= instruction[2:0];

                    case(func)
                        3'b000: begin // add
                            alu <= 2'b00;
                            mux8 <= 0;
                            mux8to16 <= 1;
                            registerFileEnable <= 1;
                            extenderControl <= 0;
                            mux16A <= 0;
                            mux16B <= 0;
                            dataMemoryEnable <= 0;
                            beq <= 0;
                        end
                        3'b010: begin // sub
                            alu <= 2'b01;
                            mux8 <= 0;
                            mux8to16 <= 1;
                            registerFileEnable <= 1;
                            extenderControl <= 0;
                            mux16A <= 0;
                            mux16B <= 0;
                            dataMemoryEnable <= 0;
                            beq <= 0;
                        end
                        3'b100: begin // and
                            alu <= 2'b10;
                            mux8 <= 0;
                            mux8to16 <= 1;
                            registerFileEnable <= 1;
                            extenderControl <= 0;
                            mux16A <= 0;
                            mux16B <= 0;
                            dataMemoryEnable <= 0;
                            beq <= 0;
                        end
                        3'b101: begin // or
                            alu <= 2'b11;
                            mux8 <= 0;
                            mux8to16 <= 1;
                            registerFileEnable <= 1;
                            extenderControl <= 0;
                            mux16A <= 0;
                            mux16B <= 0;
                            dataMemoryEnable <= 0;
                            beq <= 0;
                        end
                    endcase

                    address1 <= instruction[8:6];
                    address2 <= instruction[5:3];
                    addressData <= instruction[11:9];
                end
                4'b0100: begin // addi
                    alu <= 2'b00;
                    mux8 <= 1;
                    mux8to16 <= 1;
                    registerFileEnable <= 1;
                    extenderControl <= 0;
                    mux16A <= 0;
                    mux16B <= 0;
                    dataMemoryEnable <= 0;
                    beq <= 0;
                    imm <= instruction[5:0];
                    address1 <= instruction[8:6];
                    addressData <= instruction[11:9];
                end
                4'b1011: begin // lw
                    alu <= 2'b00;
                    mux8 <= 1;
                    mux8to16 <= 0;
                    registerFileEnable <= 0;
                    extenderControl <= 0;
                    mux16A <= 0;
                    mux16B <= 0;
                    dataMemoryEnable <= 1;
                    beq <= 0;
                    imm <= instruction[5:0];
                    address1 <= instruction[8:6];
                    addressData <= instruction[11:9];
                end
                4'b1111: begin // sw
                    alu <= 2'b00;
                    mux8 <= 1;
                    mux8to16 <= 0;
                    registerFileEnable <= 1;
                    extenderControl <= 0;
                    mux16A <= 0;
                    mux16B <= 0;
                    dataMemoryEnable <= 0;
                    beq <= 0;
                    imm <= instruction[5:0];
                    address1 <= instruction[8:6];
                    addressData <= instruction[11:9];
                end
                4'b1000: begin // beq
                    alu <= 2'b01;
                    mux8 <= 1;
                    mux8to16 <= 0;
                    registerFileEnable <= 0;
                    extenderControl <= 0;
                    mux16A <= 0;
                    mux16B <= 0;
                    dataMemoryEnable <= 0;
                    beq <= zero;
                    imm <= instruction[5:0];
                end
                4'b0010: begin // j
                    alu <= 2'b00;
                    mux8 <= 0;
                    mux8to16 <= 0;
                    registerFileEnable <= 0;
                    extenderControl <= 1;
                    mux16A <= 1;
                    mux16B <= 1;
                    dataMemoryEnable <= 0;
                    beq <= 0;
                    addr <= instruction[7:0];
                end
            endcase
        end
    end

endmodule