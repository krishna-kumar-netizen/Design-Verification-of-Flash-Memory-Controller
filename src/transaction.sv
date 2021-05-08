class transaction;
 
  //declaring the transaction items
 rand bit  BF_Sel;
  rand bit [10:0] BF_ad;
  rand bit [7:0] BF_din;
  rand bit BF_we;
  rand bit [15:0] RWA;
  rand bit [2:0] nfc_cmd;
  rand bit nfc_strt;
  rand bit R_nB;
  
  
  bit [7:0] BF_dou;
  bit Perr,EErr,RErr;
  bit [1:0] cnt;
  bit nfc_done;
  bit CLE,ALE,WE_n,RE_n,CE_n;
   
  //constaint, to generate any one among write and read
  //constraint wr_rd_c { wr_en != rd_en; };
   
endclass