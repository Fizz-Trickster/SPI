`include "spi_master.sv"

module spi_top                          #(
//========================================== 
// Parameter Description
//==========================================
parameter   DWIDTH               = 8    )(
//========================================== 
// Input / Output Description
//========================================== 
input                   i_clk,
input                   rst_n,

input   [DWIDTH-1:0]    i_TX_BYTE,          // From Internal System
input                   i_TX_DE,            // Data Enable

output  [DWIDTH-1:0]    o_RX_BYTE,          // To Internal Systen
output                  o_RX_DE,            // Data Enable

input                   clockPolarity,
input                   clockPhase,
// SPI Interface
output                  o_spi_clk,
input                   i_spi_miso,
output                  o_spi_mosi,
output                  o_spi_cs
);

spi_master u_spi_master (
        .i_clk                  ( i_clk                                       
    ),  .rst_n                  ( rst_n

    ),  .i_TX_BYTE              ( i_TX_BYTE     
    ),  .i_TX_DE                ( i_TX_DE            

    ),  .o_RX_BYTE              ( o_RX_BYTE
    ),  .o_RX_DE                ( o_RX_DE            

    ),  .clockPolarity          ( clockPolarity
    ),  .clockPhase             ( clockPhase

    ),  .o_spi_clk              ( o_spi_clk
    ),  .i_spi_miso             ( i_spi_miso
    ),  .o_spi_mosi             ( o_spi_mosi
    ),  .o_spi_cs               ( o_spi_cs
    )
);          


endmodule