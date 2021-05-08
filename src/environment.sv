// Environment defined
   
class environment;
   
  //generator and driver instance
  generator gen;
  driver    driv;
   
  //mailbox handle's
  mailbox gen2driv;
   
  //event for synchronization between generator and test
  event gen_ended;
   
  //virtual interface
  virtual mem_intf mem_vif;
  logic [7:0] memory[0:2047];
  logic [15:0] addr;

   
  //constructor
  function new(virtual mem_intf mem_vif);
    //get the interface from test
    this.mem_vif = mem_vif;
     
    //creating the mailbox (Same handle will be shared across generator and driver)
    gen2driv = new();
     
    //creating generator and driver
    gen = new(gen2driv,gen_ended);
    driv = new(mem_vif,gen2driv);
  endfunction

    

  task test();
    fork
    gen.main();
    
   
    join_any
  endtask
   
  task post_test();
    wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
  endtask 
   
  //run task
  task run;
    
    test();
    post_test();
   
  endtask  
endclass
