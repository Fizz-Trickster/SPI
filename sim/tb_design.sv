// How To Simulate
// https://edaplayground.com 


`timescale 1ns/1ps

module tb_design;

    logic 		clk;
    logic 		reset_n;

    logic       spi_clk;
    logic       spi_miso;
    logic       spi_mosi; 

  // dump file
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  always #5 clk = ~clk;
  
  initial begin
    		reset_n = 'd1;
    #2		reset_n = 'd0;
    #5		reset_n = 'd1;
    
    		clk = 'd0; 
    
    
    #10_000	$finish;
    
  end
  
  spi_top u_spi_top(
 		.i_clk					(clk        
    ),	.rst_n					(reset_n   
    ),	.o_spi_clk				(spi_clk	   
    ),	.o_spi_miso				(spi_miso
    ),	.o_spi_mosi				(spi_mosi
    )
  );
 
endmodule