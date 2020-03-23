`default_nettype none
module servmax1000
(
 input wire 	   i_clk,
 input wire 	   i_rst,
 output wire 	   q,
 output wire 	   uart_txd);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign wb_rst = ~i_rst;
   assign uart_txd = q;

   pll clock_gen
     (.inclk0 (i_clk),
   	  .c0     (wb_clk)
      );

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

endmodule
