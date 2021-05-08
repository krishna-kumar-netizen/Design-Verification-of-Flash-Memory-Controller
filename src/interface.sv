//driver clocking block
interface mem_intf(input logic clk,reset);
   
  //declaring the signals
  
  wire [7:0] DIO;
  logic  BF_Sel;
  logic [10:0] BF_ad;
  logic [7:0] BF_din;
  logic BF_we;
  logic [15:0] RWA;
  logic [2:0] nfc_cmd;
  logic nfc_strt;
  logic R_nB;
    
  logic [7:0] BF_dou;
  logic Perr,EErr,RErr;
  logic [1:0] cnt;
  logic nfc_done;
  logic CLE,ALE,WE_n,RE_n,CE_n;
  

clocking driver_cb @(posedge clk);
  default input #1 output #1;
  output DIO;
  output  BF_Sel;
  output BF_ad;
  output BF_din;
  output BF_we;
  output RWA;
  output nfc_cmd;
  output  nfc_strt;
  output  R_nB;
  input BF_dou;
  input Perr,EErr,RErr;
  input cnt;
  input nfc_done;
  input CLE,ALE,WE_n,RE_n,CE_n;
endclocking
  
//monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
  input DIO;
  input  BF_Sel;
  input BF_ad;
  input BF_din;
  input BF_we;
  input RWA;
  input nfc_cmd;
  input  nfc_strt;
  input  R_nB;
  input BF_dou;
  input Perr,EErr,RErr;
  input cnt;
  input nfc_done;
  input CLE,ALE,WE_n,RE_n,CE_n;
  endclocking
   
  //driver modport
  modport DRIVER  (clocking driver_cb,input clk,reset);
   
  //monitor modport 
  modport MONITOR (clocking monitor_cb,input clk,reset);
   
endinterface
