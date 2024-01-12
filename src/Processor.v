`include "Adder.v"
`include "Alu.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "Extender.v"
`include "InstructionMemory.v"
`include "Mux.v"
`include "ProgramCounter.v"
`include "RegisterFile.v"

module Processor (
    input   wire    clk,
    input   wire    rst
);
    wire    [7:0]   programCounterInput; //
    wire    [7:0]   programCounterOutput;
    wire    [15:0]  instructionMemoryOutput;
    wire            aluFlagZero;
    wire            registerFileEnable;
    wire    [2:0]   registerFileAddress1;
    wire    [2:0]   registerFileAddress2;
    wire    [2:0]   registerFileAddressData;
    wire    [5:0]   extenderImm;
    wire    [7:0]   extenderAddr;
    wire            extenderControl;
    wire            extenderBeq;
    wire    [7:0]   registerFileData2;
    wire            muxDControl;
    wire    [7:0]   extendedMuxD;
    wire    [7:0]   muxedD;
    wire    [7:0]   registerFileData1;
    wire    [1:0]   aluControl;
    wire    [7:0]   aluResult;
    wire    [7:0]   extendedMuxC;
    wire            muxCControl;
    reg     [7:0]   plus8 = 8'd8;
    wire    [7:0]   muxedC;
    wire            dataMemoryEnable;
    wire    [7:0]   registerFileDataMemory;
    wire    [7:0]   dataMemoryOutput;
    wire            muxAControl;
    wire    [7:0]   muxedA;
    wire    [7:0]   adderResult;
    wire            muxBControl;

    Mux muxB(
        .inputControl0(adderResult),
        .inputControl1(muxedA),
        .control(muxBControl),
        .muxed(programCounterInput)
    );

    Adder adder(
        .inputAdd(muxedC),
        .inputInstruction(programCounterOutput),
        .result(adderResult)
    );

    Mux muxA(
        .inputControl0(dataMemoryOutput),
        .inputControl1(aluResult),
        .control(muxAControl),
        .muxed(muxedA)
    );

    DataMemory dataMemory(
        .clk(clk),
        .rst(rst),
        .enable(dataMemoryEnable),
        .address(aluResult),
        .dataInput(registerFileDataMemory),
        .dataOutput(dataMemoryOutput)
    );

    Mux muxC(
        .inputControl0(plus8),
        .inputControl1(extendedMuxC),
        .control(muxCControl),
        .muxed(muxedC)
    );

    Alu alu(
        .inputA(registerFileData1),
        .inputB(muxedD),
        .control(aluControl),
        .result(aluResult),
        .zero(aluFlagZero)
    );

    Mux muxD(
        .inputControl0(registerFileData2),
        .inputControl1(extendedMuxD),
        .control(muxDControl),
        .muxed(muxedD)
    );

    Extender extender(
        .imm(extenderImm),
        .addr(extenderAddr),
        .control(extenderControl),
        .beq(extenderBeq),
        .extendedControl0(extendedMuxD),
        .extendedControl1(extendedMuxC)
    );

    RegisterFile registerFile(
        .clk(clk),
        .rst(rst),
        .enable(registerFileEnable),
        .address1(registerFileAddress1),
        .address2(registerFileAddress2),
        .addressData(registerFileAddressData),
        .dataIn(muxedA),
        .data1(registerFileData1),
        .data2(registerFileData2),
        .dataMemory(registerFileDataMemory)
    );

    ControlUnit controlUnit(
        .clk(clk),
        .rst(rst),
        .instruction(instructionMemoryOutput),
        .zero(aluFlagZero),
        .address1(registerFileAddress1),
        .address2(registerFileAddress2),
        .addressData(registerFileAddressData),
        .imm(extenderImm),
        .addr(extenderAddr),
        .alu(aluControl),
        .muxD(muxDControl),
        .registerFileEnable(registerFileEnable),
        .extenderControl(extenderControl),
        .muxA(muxAControl),
        .muxB(muxBControl),
        .muxC(muxCControl),
        .dataMemoryEnable(dataMemoryEnable),
        .beq(extenderBeq)
    );

    InstructionMemory instructionMemory(
        .clk(clk),
        .rst(rst),
        .address(programCounterOutput),
        .dataOutput(instructionMemoryOutput)
    );

    ProgramCounter programCounter(
        .clk(clk),
        .rst(rst),
        .next(programCounterInput),
        .current(programCounterOutput)
    );
endmodule