// variable

// Sends a single byte from master.
task SendSingleByte(input [7:0] data);
  @(posedge tb_design.clk);  
  $display("======================================");
  $display("time :" , $stime,"\nSend Signle Byte!!");
  $display("======================================");
  tb_design.Master_TX_Byte <= data;
  tb_design.Master_TX_DE   <= 1'b1;
  @(posedge tb_design.clk);
  tb_design.Master_TX_DE   <= 1'b0;
endtask // SendSingleByte