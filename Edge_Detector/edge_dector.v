`timescale 1ns / 1ps
module edge_detector (
    input wire clk,
    input wire reset,
    input wire signal,
    output reg zero_delay_rising,
    output reg zero_delay_falling,
    output reg zero_delay_either,
    output reg cycle_delayed_rising,
    output reg cycle_delayed_falling,
    output reg cycle_delayed_either
);

reg signal_d1, signal_d2;

// Zero-delayed edge detection
always @(posedge clk or posedge reset or negedge clk ) begin
    if (reset) begin
        zero_delay_rising <= signal;
        zero_delay_falling <= ~signal;
        zero_delay_either <= signal;
    end else begin
        zero_delay_rising <= (signal && ~signal_d1) || (reset && signal);
        zero_delay_falling <= ~signal && signal_d1;
        zero_delay_either <= signal ^ signal_d1;
    end
end

// Cycle-delayed edge detection
always @(posedge clk or posedge reset) begin
    if (reset) begin
        signal_d1 <= 0;
        signal_d2 <= 0;
        cycle_delayed_rising <= 0;
        cycle_delayed_falling <= 0;
        cycle_delayed_either <= 0;
    end else begin
    signal_d1 <= signal;
        signal_d2 <= signal_d1;  
        cycle_delayed_rising <= (signal && ~signal_d2) || (signal&&~signal_d1);
        cycle_delayed_falling <= ~signal && signal_d1;
        cycle_delayed_either <= signal ^ signal_d1 ^ signal_d2;
    end
end

endmodule
