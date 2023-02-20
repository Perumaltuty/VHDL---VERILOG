`timescale 1ns / 1ps
module edge_detector_tb;

reg clk;
reg reset;
reg signal;

wire zero_delay_rising;
wire zero_delay_falling;
wire zero_delay_either;
wire cycle_delayed_rising;
wire cycle_delayed_falling;
wire cycle_delayed_either;

edge_detector dut (
    .clk(clk),
    .reset(reset),
    .signal(signal),
    .zero_delay_rising(zero_delay_rising),
    .zero_delay_falling(zero_delay_falling),
    .zero_delay_either(zero_delay_either),
    .cycle_delayed_rising(cycle_delayed_rising),
    .cycle_delayed_falling(cycle_delayed_falling),
    .cycle_delayed_either(cycle_delayed_either)
);

initial begin
    clk = 0;
    reset = 1;
    signal = 0;
    #10 reset = 0;
    #10 signal = 1;
    #10 signal = 0;
    #10 signal = 1;
    #10 signal = 0;
    #10 $finish;
end

always #5 clk = ~clk;

endmodule
