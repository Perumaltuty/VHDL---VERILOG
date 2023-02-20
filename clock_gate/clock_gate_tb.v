module clock_gate_tb();

reg clk_i;
reg en_i;
wire clk_o;

clock_gate dut(
  .clk_i(clk_i),
  .en_i(en_i),
  .clk_o(clk_o)
);


  
  
  clk_i = 0;
  en_i = 0;
  #10;
  #5 en_i=1;
  #10 en_i=0;
 

  always#5 clk_i=~clk_i;

 #100  $finish;


endmodule
