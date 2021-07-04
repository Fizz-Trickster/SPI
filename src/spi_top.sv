module spi_top                          #(
//========================================== 
// Parameter Description
//==========================================
parameter       FOAM_DUATION    = 10    ,
parameter       SCRUB_DUATION   = 16    ,
parameter       RINSE_DUATION   = 10    ,
parameter       BLOWDRY_DUATION = 12    )(
//========================================== 
// Input / Output Description
//========================================== 
input               i_clk,
input               rst_n,
input               start_but_pressed,

// SPI Interface
output              o_spi_clk,
input               i_spi_miso,
output              o_spi_mosi
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
reg     [2:0]       cur_State;
reg     [2:0]       nxt_State;
reg     [4:0]       minutes_timer;
reg     [4:0]       minutes_timer_nxt;
reg                 do_foam_dispensing;
reg                 do_foam_dispensing_nxt;
reg                 do_scrubbing;
reg                 do_scrubbing_nxt;
reg                 do_rinsing;
reg                 do_rinsing_nxt;
reg                 do_drying;
reg                 do_drying_nxt;
wire                foam_done;
wire                scrubbing_done;
wire                rinsing_done;
wire                drying_done;
wire                timer_expired;
wire    [4:0]       minutes_timer_minus_one; 

assign timer_expired            = (minutes_timer == 'd0);
assign foam_done                = timer_expired;
assign scrubbing_done           = timer_expired;
assign rinsing_done             = timer_expired;
assign drying_done              = timer_expired;
assign minutes_timer_minus_one  = minutes_timer - 1'b1;

always @(*) begin
    nxt_State               = cur_State;
    minutes_timer_nxt       = minutes_timer;
    do_foam_dispensing_nxt  = 1'b0;
    do_scrubbing_nxt        = 1'b0;
    do_rinsing_nxt          = 1'b0;
    do_drying_nxt           = 1'b0;

    case(cur_State) 
        IDLE: begin
            if(start_but_pressed) begin   
                nxt_State               = FOAM;
                do_foam_dispensing_nxt  = 1'b1;
                minutes_timer_nxt       = FOAM_DUATION;
            end
        end
        FOAM: begin
            if(foam_done) begin   
                nxt_State               = SCRUB;
                do_foam_dispensing_nxt  = 1'b0;
                do_scrubbing_nxt        = 1'b1;
                minutes_timer_nxt       = SCRUB_DUATION;
            end
            else begin
                do_foam_dispensing_nxt  = 1'b1;
                minutes_timer_nxt       = minutes_timer_minus_one;
            end
        end
        SCRUB: begin
            if(scrubbing_done) begin                   
                nxt_State               = RINSE;
                do_scrubbing_nxt        = 1'b0;
                do_rinsing_nxt          = 1'b1;
                minutes_timer_nxt       = RINSE_DUATION;
            end
            else begin
                do_scrubbing_nxt        = 1'b1;
                minutes_timer_nxt       = minutes_timer_minus_one;
            end
        end
        default : begin end
    endcase
end

always @(posedge i_clk, negedge rst_n) begin
    if(~rst_n)          cur_State <= IDLE;
    else                cur_State <= nxt_State;                
end

always @(posedge i_clk, negedge rst_n) begin
    if(~rst_n) begin
        minutes_timer       = 'd0;
        do_foam_dispensing  = 'b0;
        do_scrubbing        = 'b0;
        do_rinsing          = 'b0;
        do_drying           = 'b0;
    end         
    else begin
        minutes_timer       = minutes_timer_nxt;
        do_foam_dispensing  = do_foam_dispensing_nxt;
        do_scrubbing        = do_scrubbing_nxt;
        do_rinsing          = do_rinsing_nxt;
        do_drying           = do_drying_nxt;
    end                
end

endmodule