module ff_synchroniser #
(
    parameter pre_reg   = 0,
    parameter re_edge   = 1,
    parameter sync_size = 2
)
(
    input  wire        clk_a,
    input              sig_a,
    input  wire        clk_b,
    output             sig_b
);

  reg [sync_size-2:0] sig_b_int;
  reg [sync_size-2:0] sig_a_int;

    
    generate if (pre_reg) begin : A1
        always @(posedge clk_a) begin
            if (re_edge) begin
                sig_a_int <= sig_a;
            end else begin
                sig_a_int <=  sig_a;
            end
        end
    end else begin : A2
      assign sig_a_int[sync_size-2] = sig_a;
    end endgenerate

    always @(posedge clk_b) begin   
        if (re_edge) begin
          sig_b_int <= {sig_b_int[sync_size-2:0], sig_a_int};
        end else begin
          sig_b_int <= {sig_b_int[sync_size-2:0], sig_a_int};
        end
    end
 
  assign sig_b = sig_b_int[sync_size-2];

endmodule
