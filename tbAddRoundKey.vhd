library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY addRoundKey_tb IS 
END addRoundKey_tb;

ARCHITECTURE behavior OF addRoundKey_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT addRoundKey  --'test' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    port (
		In_State  	: in  Matrix;
		In_RoundKey : in Matrix;
		Out_State	: out Matrix);
    
    END COMPONENT;
   --declare inputs and initialize them
   signal instate : Matrix := (("10111010", "01110101", "11110100", "01111010"), 
							   ("10000100", "10100100", "10001101", "00110010"),
						       ("11101000", "10001101", "00000110", "00001110"),
						       ("00011011", "01000000", "01111101", "01011101"));
						       
   signal inroundkey : Matrix := (("11100010", "00110010", "11111100", "11110001"), 
								  ("10010001", "00010010", "10010001", "10001000"),
								  ("10110001", "01011001", "11100100", "11100110"),
								  ("11010110", "01111001", "10100010", "10010011"));
   signal outM : Matrix;
   -- Clock period definitions
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: addRoundKey PORT MAP (
          In_State => instate,
          In_RoundKey => inroundkey,
          Out_State => outM
        );       

END;
      
      