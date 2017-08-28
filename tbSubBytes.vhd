library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY subBytes_tb IS 
END subBytes_tb;

ARCHITECTURE behavior OF subBytes_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT subBytes  --'test' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    port (
		In_State  	: in  Matrix;
		Out_State	: out Matrix);
    
    END COMPONENT; 
   --declare inputs and initialize them
   signal instate : Matrix := (("00000000", "00011111", "00001110", "01010100"), 
							   ("00111100", "01001110", "00001000", "01011001"),
						       ("01101110", "00100010", "00011011", "00001011"),
						       ("01000111", "01110100", "00110001", "00011010"));
   signal outM : Matrix;
   -- Clock period definitions
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: subBytes PORT MAP (
          In_State => instate,
          Out_State => outM
        );       

END;
      
      