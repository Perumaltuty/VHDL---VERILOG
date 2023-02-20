`timescale 1ns / 1ps

module data_synchronizer 
#(
   parameter STAGES = 2,                  // Recommended 2 flip-flops for low speed designs; >2 for high speed
   parameter DWIDTH = 8                   // Data width
)
(
   input  wire              clk,         // Clock
   input  wire              rstn,        // Synchronous Reset
   input  wire  [DWIDTH-1:0] din,        // Asynchronous Data in
   input  wire              dready_i,    // Asynchronous Data ready in
   output reg  [DWIDTH-1:0] dout,        // Synchronous Data out
   output reg              dready_o     // Synchronous Data ready out
);
// Synchronisation Chain of Flip-Flops for Data ready



// Data ready signal synchronised

(* ASYNC_REG = "true" *) reg [STAGES-1:0] flipflops;
(* ASYNC_REG = "true" *) reg dready_sync;
always @(posedge clk)
begin
   if (~rstn) begin
      flipflops <= 'b0;
   end else begin
      flipflops <= {flipflops[STAGES-2:0], dready_i};
   end
end
// Register process for Data in


always @(posedge clk)
begin
   if (~rstn) begin
      dout <= 'b0;
      dready_o <= 1'b0;
   end else begin
      if (dready_sync) begin
         dout <= din;
      end
      dready_o <= dready_sync;
   end
end
// Synchronised signal out

always @(posedge clk)
begin
   dready_sync <= flipflops[STAGES-1];
end

endmodule
