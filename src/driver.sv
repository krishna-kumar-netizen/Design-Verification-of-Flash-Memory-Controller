`define DRIV_IF mem_vif.DRIVER.driver_cb
class driver;
   
  //used to count the number of transactions
  int no_transactions;
   
  //creating virtual interface handle
  virtual mem_intf mem_vif;
   
  //creating mailbox handle
  mailbox gen2driv;
   
  //constructor
  function new(virtual mem_intf mem_vif,mailbox gen2driv);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handle from  environment
    this.gen2driv = gen2driv;
  endfunction
    
    task drive(input int cmd, input logic [15:0] address);
 
    case (cmd)
    program_page: begin
                  @(posedge mem_vif.DRIVER.clk);
                      #3
     				 $display("reached program page");
                    `DRIV_IF.RWA <= address;
                    `DRIV_IF.nfc_cmd <= 3'b001;
                    `DRIV_IF.nfc_strt <= 1'b1;
                    `DRIV_IF.BF_Sel <= 1'b1;
                  @(posedge mem_vif.DRIVER.clk);
                      #3
                    `DRIV_IF.nfc_strt <= 1'b0;
                    `DRIV_IF.BF_ad <= 1'b0;
      			   end
    read_page :	begin
					 @(posedge mem_vif.DRIVER.clk);
    					#3
      					$display("reached the read operation task");
    					`DRIV_IF.RWA<=address;
    					`DRIV_IF.nfc_cmd<=3'b010;
    					`DRIV_IF.nfc_strt<=1'b1;
    					`DRIV_IF.BF_Sel<=1'b1;
    					`DRIV_IF.BF_we<=1'b0;
    					`DRIV_IF.BF_ad<=3'b0;
    					 @(posedge mem_vif.DRIVER.clk);
    					#3;
    					`DRIV_IF.nfc_strt<=1'b0; 
						`DRIV_IF.BF_ad<=0; 
				end
	erase	 :	begin
					 @(posedge mem_vif.DRIVER.clk);
    					#3
    					`DRIV_IF.RWA<=address;
    					`DRIV_IF.nfc_cmd<=3'b100;
    					`DRIV_IF.nfc_strt<=1'b1;
    					
    					 @(posedge mem_vif.DRIVER.clk);
    					#3;
    					`DRIV_IF.nfc_strt<=1'b0; 
	 
				end
     read_id	 :	begin
					 @(posedge mem_vif.DRIVER.clk);
    					#3
    					`DRIV_IF.RWA<=address;
    					`DRIV_IF.nfc_cmd<=3'b101;
    					`DRIV_IF.nfc_strt<=1'b1;
    					
    					 @(posedge mem_vif.DRIVER.clk);
    					#3;
    					`DRIV_IF.nfc_strt<=1'b0; 
	 
				end
      
       
    endcase
    no_transactions++;
	endtask

    task write_buffer(input bit bf_we, input bit[7:0] bf_din, input int i);
			@(posedge mem_vif.DRIVER.clk);
			#3;
			`DRIV_IF.BF_we <= bf_we;
			`DRIV_IF.BF_din <= bf_din;
      		#3
     		`DRIV_IF.BF_ad <=  i; 
	endtask : write_buffer

	task read_buffer(input int i);                                                                
       		@(posedge mem_vif.DRIVER.clk);
      		#3
       		`DRIV_IF.BF_ad<= i; 
			`DRIV_IF.BF_we<= 0;
    endtask : read_buffer
/*
    task system_reset(input int count);
	@(posedge mem_vif.DRIVER.clk);
	mem_vif.DRIVER.reset <= 1'b1;
        $display($time,"Entered reset block to check if it is entering in same clk");
	repeat (count) @(posedge mem_vif.DRIVER.clk);
	mem_vif.DRIVER.reset <= 1'b0;
	endtask : system_reset
*/
  
  task kill_time;                                                         
  begin                                                                 
    @(posedge mem_vif.DRIVER.clk);                                                
    @(posedge mem_vif.DRIVER.clk);                                                
    @(posedge mem_vif.DRIVER.clk);                                                 
 
    @(posedge mem_vif.DRIVER.clk);                                              
    @(posedge mem_vif.DRIVER.clk);
  end
  endtask : kill_time
  /*  
  task main;
  forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(mem_vif.reset);
        end
        //Thread-2: Calling drive task
        begin
          forever
            drive();
        end
      join_any
      disable fork;
    end
  endtask : main
   */
endclass