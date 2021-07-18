// How To Simulate
// https://edaplayground.com 

`timescale 1ns/1ps

`include "task_spi.sv"

module tb_design;
//========================================== 
// Parameter Description
//==========================================
parameter       CLOCK_PERIOD = 10;  // 100 MHz

logic           clk;
logic           reset_n;

logic           spi_clk;
logic           spi_miso        = 0;
logic           spi_mosi; 
logic           spi_cs; 

logic   [7:0]   Master_TX_Byte;
logic           Master_TX_DE    = 0;

logic   [7:0]   Master_RX_Byte  ;
logic           Master_RX_DE    ;

logic           clockPolarity   = 0;
logic           clockPhase      = 0; 


// clock generation
always #(CLOCK_PERIOD/2) clk = ~clk;

// dump file
initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars;
end
  
spi_top u_spi_top (
        .i_clk                  ( clk                                       
    ),  .rst_n                  ( reset_n

    ),  .i_TX_BYTE              ( Master_TX_Byte     
    ),  .i_TX_DE                ( Master_TX_DE            

    ),  .o_RX_BYTE              ( Master_RX_Byte
    ),  .o_RX_DE                ( Master_RX_DE            

    ),  .clockPolarity          ( clockPolarity
    ),  .clockPhase             ( clockPhase

    ),  .o_spi_clk              ( spi_clk
    ),  .i_spi_miso             ( spi_miso
    ),  .o_spi_mosi             ( spi_mosi
    ),  .o_spi_cs               ( spi_cs
    )
 );

  
initial begin
  		reset_n = 'd1;
  #2	reset_n = 'd0;
  #5	reset_n = 'd1;
  		clk = 'd0; 

        repeat (5) @(posedge clk);
        SendSingleByte(8'hFF);
  
        repeat (5) @(posedge clk);
        SendSingleByte(8'hAC);
  
  #1_000	$finish;
  
end
  
endmodule