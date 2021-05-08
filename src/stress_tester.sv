
// `include "environment.sv"

program test(mem_intf intf);
  
  environment env;
  logic [7:0] memory[0:2047];
  logic [15:0] addr;
  
  function logic [15:0] Address_Rand();
      logic [15:0]Address;
      Address= $urandom_range(1023,0);
      return Address;
    endfunction

  
   task write_cycle(input logic [15:0]addr);
	env.driv.drive(3'b001,addr);
	for(int i=0; i<2048; i++) begin
		memory[i]=$random % 256; 
		env.driv.write_buffer(1'b1,memory[i],i);
	end
    endtask

    task read_data();
        for(int i=0; i<2048; i++) begin
            env.driv.read_buffer(i);
        end
    endtask

    task read_cycle(input bit [15:0]addr);
        env.driv.drive(3'b010,addr);
    endtask

    task erase_cycle(input bit [15:0]addr);
        env.driv.drive(3'b100,addr);
    endtask

    task reset_cycle();
        env.driv.drive(3'b011,16'h1234);
    endtask

    task read_id_cycle();
        env.driv.drive(3'b101,16'h0000);
    endtask
  
    task kill(input int i);
      repeat(i)@(posedge env.mem_vif.clk);		
  endtask


  
  initial begin
    //creating environment
    env = new(intf);
    env.driv.drive(3'b000, 16'h0000);
    
    
    
    
    //Consequtive writes
    write_cycle(16'h00C1);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h00C2);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h00C3);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h00C4);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h00C5);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h00C6);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    //Consqutive reads
    read_cycle(16'h00c1);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    read_cycle(16'h00c2);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    read_cycle(16'h00c3);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    read_cycle(16'h00c4);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    read_cycle(16'h00c5);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    read_cycle(16'h00c6);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    
    
    
    
    
    //Writing to different blocks
    write_cycle(16'h0051);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h0009);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
	write_cycle(16'h00c7);
     wait(env.mem_vif.nfc_done);
    $display("page write completed 00c7\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
	
    kill(20);
	erase_cycle(16'h00c8);
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("erase completed 00c8\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    
    read_cycle(16'h00c8);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    //kill(15);
    kill(10);
    

    kill(20);
	reset_cycle();
	repeat(10)@(posedge env.mem_vif.clk);
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("reset completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;

	kill(10);
	read_id_cycle();
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("read id completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;


    //my_tr = new();
    for(int i=0; i<512; i++) begin
		env.driv.read_buffer(i);
	end
    env.run();
    
    

    
    
    //Writing to different blocks
    write_cycle(16'h0051);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    write_cycle(16'h0009);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
	write_cycle(16'h00c7);
     wait(env.mem_vif.nfc_done);
    $display("page write completed 00c7\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
	
    kill(20);
	erase_cycle(16'h00c8);
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("erase completed 00c8\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    
    read_cycle(16'h00c8);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    //kill(15);
    kill(10);
    

    kill(20);
	reset_cycle();
	repeat(10)@(posedge env.mem_vif.clk);
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("reset completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;

	kill(10);
	read_id_cycle();
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("read id completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;


    //my_tr = new();
    for(int i=0; i<512; i++) begin
		env.driv.read_buffer(i);
	end
    env.run();
    
    
    //Reading random writes 
    
    read_cycle(16'h0051);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
    read_cycle(16'h0009);
    wait(env.mem_vif.nfc_done);
    $display("page write completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    kill(10);
    
	read_cycle(16'h00c7);
     wait(env.mem_vif.nfc_done);
    $display("page write completed 00c7\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
	
    kill(20);
	erase_cycle(16'h00c8);
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("erase completed 00c8\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    
    read_cycle(16'h00c8);
    kill(5);
    wait(env.mem_vif.nfc_done);
    $display("page read completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;
    //kill(15);
    kill(10);
    

    kill(20);
	reset_cycle();
	repeat(10)@(posedge env.mem_vif.clk);
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("reset completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;

	kill(10);
	read_id_cycle();
    kill(5);
	 wait(env.mem_vif.nfc_done);
    $display("read id completed\n");
    @(posedge env.mem_vif.clk) ;
   		 env.mem_vif.nfc_cmd=3'b111;


    //my_tr = new();
    for(int i=0; i<512; i++) begin
		env.driv.read_buffer(i);
	end
    env.run();
    
    
    
    
    
  end
endprogram