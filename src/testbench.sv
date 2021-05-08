`include "flash_interface.sv"
`include "environment.sv"
`include "tester.sv"
//`include "stress_tester.sv"
typedef enum bit [2:0] {program_page  	= 3'b001,
				read_page  	= 3'b010,
				erase  		= 3'b100,
				reset  		= 3'b011,
				read_id  	= 3'b101
				} operations;

operations op, exp_op, scr_op;

parameter TRUE = 1'b1;
parameter FALSE = 1'b0;
parameter SIGNAL_WIDTH=4;
parameter SB_DEPTH=24;
parameter LUT=3;

parameter DEBUG = TRUE;
    
module tbench_top;
  
  //clock and reset signal declaration
  bit clk;
  bit reset;
  
 
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  
  
  mem_intf intf(clk,reset);
  
  
  test t1(intf);
  
  
  nfcm_top DUT (
    intf.DIO,
    intf.CLE,
    intf.ALE,
    intf.WE_n,
  intf.RE_n,
  intf.CE_n,
  intf.R_nB,
  intf.clk,
  intf.reset,
  intf.BF_Sel ,
  intf.BF_ad  ,
  intf.BF_din ,
  intf.BF_dou ,
  intf.BF_we,
  intf.RWA,
  intf.Perr,
  intf.EErr,
  intf.RErr,
  intf.nfc_cmd ,
  intf.nfc_strt,
  intf.nfc_done
);
  
  flash_interface nand_flash(
    .DIO(intf.DIO),
    .CLE(intf.CLE),	// -- CLE
    .ALE(intf.ALE),	//  -- ALE
    .WE_n(intf.WE_n),	// -- ~WE
    .RE_n(intf.RE_n), 	//-- ~RE
    .CE_n(intf.CE_n), 	//-- ~CE
    .R_nB(intf.R_nB), 	//-- R/~B
    .rst(intf.reset)
);

  always @(DUT.addr_counter.cnt_state)
    if(DUT.addr_counter.cnt_state==12'h7FF)
      $display("Reached the address count of 2048",DUT.addr_counter.TC2048);
  
initial begin
  #10
  reset = 1;
    #5 reset =0;
  #10
  $display("reached here after reset");
  #5000000;
  //$display("Addr count value=%d\t%d",DUT.addr_counter.cnt_state,DUT.addr_counter.TC2048);
  $finish;
end
  
  //enabling the wave dump
  initial begin 
  #10
    $display("**--Dumping waveform--**");
    
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule
