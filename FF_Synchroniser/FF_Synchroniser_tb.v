module ff_synchroniser_tb();
  reg       clk_a;
    reg        sig_a;
    reg        clk_b;
    wire         sig_b;
  ff_synchroniser uut(.clk_a(clk_a),.sig_a(sig_a),.clk_b(clk_b),.sig_b(sig_b));
  always #2 clk_a=~clk_a;
  always #5 clk_b=~clk_b;
  
 
  initial
    begin
$monitor("time=%t,clk_a=%b,sig_a=%b,clk_b=%b,sig_b=%b",$time,clk_a,sig_a,clk_b,sig_b);
      clk_a=0;clk_b=0;sig_a=0;
      #10 sig_a=1;
      #15 sig_a=0;
      #1000 $finish;
    end
endmodule
