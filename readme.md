## **Design verificatin of Lattice semiconductor's Nand Flash memory controller.**

1. Structured design verification of all the operations of NAND FLASH Memory Controller using **system verilog**. 

    1. Generator - Stimulates the signals that drive the tests. 
    2. Driver - Converts the generated/triggered operation signals to DUT pin.
    3. transaction -  transaction of signals and operations between generator and driver.
    4. Interface - Converts the signals of Tester to DUT pins and vice versa. And also looks after the communication between DUT and monitor. 
    5. Monitor - Helps to monitor the signals that are important for testing. 
    7. Scoreboard - Compares the packects obtained from DUT with referecne meodel. Used in analysis of results and fault coverage. 
   
3. Structure

![Testbench Structure](https://github.com/krishna-kumar-netizen/Design-Verification-of-Flash-Memory-Controller/blob/main/documentation/structure.jpg)

4. Types of tests - 

    1. Fundamental tests. - Sequnetial test.
    
    3. Stress tests - 
        1. Random tests 
        2. Sequential tests 
        3. layered tests
        4. Virtual sequential tests.

5. Results Achieved 

    1.Achieved 96% coverage on the design under test which indicates that most of
    our test cases have been exercised.
    
    2.Verified the design completely and found the design to be bug free and the
    design is now ready for tape out

#### Eda play ground link - [click here to open link](https://www.edaplayground.com/x/Jh4g)  

### *More details in report* 

