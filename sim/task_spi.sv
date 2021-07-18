  // variable
  
  // Sends a single byte from master.
  task SendSingleByte(input [7:0] data);
    @(posedge tb_design.clk);
    Master_TX_Byte <= data;
    //Master_TX_DV   <= 1'b1;
    @(posedge tb_design.clk);
    //r_Master_TX_DV <= 1'b0;
    //@(posedge w_Master_TX_Ready);
  endtask // SendSingleByte