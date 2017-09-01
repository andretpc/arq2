library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY aes128_tb IS 
END aes128_tb;

ARCHITECTURE behavior OF aes128_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT aes128  --'test' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    port (
		Key  : in  Matrix;
		In_Text  : in  Matrix;
		Out_CipherText : out Matrix);
    
    END COMPONENT;
    
   --declare inputs and initialize them
   signal inK : Matrix := (("01010100", "01101000", "01100001", "01110100"), 
						   ("01110011", "00100000", "01101101", "01111001"),
						   ("00100000", "01001011", "01110101", "01101110"),
						   ("01100111", "00100000", "01000110", "01110101"));
						   
   signal inT : Matrix := (("01010100", "01110111", "01101111", "00100000"), 
						   ("01001111", "01101110", "01100101", "00100000"),
						   ("01001110", "01101001", "01101110", "01100101"),
						   ("00100000", "01010100", "01110111", "01101111"));
   signal outW : Matrix;
   -- Clock period definitions
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: aes128 PORT MAP (
          Key => inK,
          In_Text => inT,
          Out_CipherText => outW
        );       

END;
      
      