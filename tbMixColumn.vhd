library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY mixColumn_tb IS 
END mixColumn_tb;

ARCHITECTURE behavior OF mixColumn_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT mixColumn  --'test' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    port (
    In_DI  : in  Matrix;
    Out_DO : out Matrix);
    
    END COMPONENT;
   --declare inputs and initialize them
   signal inW : Matrix := (("01100011", "00101111", "10101111", "10100010"), 
						   ("11101011", "10010011", "11000111", "00100000"),
						   ("10011111", "10010010", "10101011", "11001011"),
						   ("10100000", "11000000", "00110000", "00101011"));
   signal outW : Matrix;
   -- Clock period definitions
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: mixColumn PORT MAP (
          In_DI => inW,
          Out_DO => outW
        );       

END;
      
      