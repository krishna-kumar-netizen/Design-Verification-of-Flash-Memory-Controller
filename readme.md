## ** Design verificatin of Lattice semiconductor's Nand Flash memory controller. ** 

1. Structured design verification of all the operations of NAND FLASH Memory Controller using system verilog. 

    1. Generator - 
    2. Driver - Converts the generated/triggered operation signals to DUT pin.
    3. transaction -  transaction of signals and operations between generator and driver.
    4. Interface - Converts the signals of Tester to DUT pins and vice versa. And also looks after the communication between DUT and monitor. 
    5. Monitor - Helps to monitor the signals that are important for testing. 
    7. Scoreboard - Compares the packects obtained from DUT with referecne meodel. Used in analysis of results and fault coverage. 
   
2. Structure - 

