`timescale 1ns / 1ns

module data_synchronizer_tb;

   // Inputs
   reg clk;
   reg rstn;
   reg [7:0] din;
   reg dready_i;

   // Outputs
   wire [7:0] dout;
   wire dready_o;

   // Instantiate the unit under test (UUT)
   data_synchronizer uut (
      .clk(clk),
      .rstn(rstn),
      .din(din),
      .dready_i(dready_i),
      .dout(dout),
      .dready_o(dready_o)
   );

   initial begin
      // Initialize inputs
      clk = 0;
      rstn = 0;
      din = 8'b0;
      dready_i = 0;

      // Wait for 100ns for reset to complete
      #100 rstn = 1;

      // Test case 1
      din = 8'b10101010;
      dready_i = 1;
      #20;

      // Test case 2
      din = 8'b01010101;
      dready_i = 0;
      #20;

      // Test case 3
      din = 8'b11111111;
      dready_i = 1;
      #20;

      // Test case 4
      din = 8'b00000000;
      dready_i = 1;
      #20;

      // Finish simulation
      $finish;
   end

   // Clock generation
   always #5 clk = ~clk;

endmodule
