module spi_master                       #(
//========================================== 
// Parameter Description
//==========================================
parameter   DWIDTH               = 8    )(
//========================================== 
// Input / Output Description
//========================================== 
input                   i_clk,
input                   rst_n,

input   [DWIDTH-1:0]    i_TX_BYTE,     
input                   i_TX_DE,            // Data Enable

output  [DWIDTH-1:0]    o_RX_BYTE,
output                  o_RX_DE,            // Data Enable

input                   clockPolarity,
input                   clockPhase,
// SPI Interface
output                  o_spi_clk,
input                   i_spi_miso,
output                  o_spi_mosi,
output                  o_spi_cs
);
//========================================== 
// Local Parameter Description
//========================================== 
localparam      IDLE    = 'd0;
localparam      FOAM    = 'd1;
localparam      SCRUB   = 'd2;
localparam      RINSE   = 'd3;
localparam      BLOWDRY = 'd4;

//========================================== 
// Internal Signal Description
//========================================== 
logic   [2:0]           cur_State;
logic   [2:0]           nxt_State;


endmodule