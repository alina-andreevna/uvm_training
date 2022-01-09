interface if_clk_gen();
  wire  clk;
  logic r_clk;

  assign clk = r_clk;

  modport mst (
    output clk
  );

  modport slv (
    input  clk
  );

endinterface
