library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY keyExpansion_tb IS 
END keyExpansion_tb;

ARCHITECTURE behavior OF keyExpansion_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT keyExpansion  --'test' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    port (
		In_Key  : in  Matrix;
		Out_KeyExpansion : out matrixArray);
    END COMPONENT;
    
   --declare inputs and initialize them
   signal inK : Matrix := (("01010100", "01101000", "01100001", "01110100"), 
						   ("01110011", "00100000", "01101101", "01111001"),
						   ("00100000", "01001011", "01110101", "01101110"),
						   ("01100111", "00100000", "01000110", "01110101"));
   signal outW : matrixArray;
   -- Clock period definitions
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: keyExpansion PORT MAP (
          In_Key => inK,
          Out_KeyExpansion => outW
        );       

END;
      
      