library ieee;
use ieee.std_logic_1164.all;

package aes128Pkg is
	subtype Byte is std_logic_vector(7 downto 0);
	subtype ByteInt is integer range 16#00# to 16#FF#;
	type 	Word is array (0 to 3) of Byte;
	type 	ByteArray is array (0 to 255) of ByteInt;
	type 	Matrix is array (0 to 3) of Word;
end package aes128Pkg;

library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AddRoundKey is
  
	port (
		In_State  	: in  Matrix;
		In_RoundKey : in Matrix;
		Out_State	: out Matrix);

end entity AddRoundKey;

architecture Behavioral of AddRoundKey is

signal Matrix_D : Matrix;
begin
	process (Matrix_D, In_State, In_RoundKey)
	begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			Matrix_D(i)(j) <= In_State(i)(j) xor In_RoundKey (i)(j);
		end loop;
	end loop;
	end process;

	process (Matrix_D)
	begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			Out_State(i)(j) <= Matrix_D(i)(j);
		end loop;
	end loop;
	end process;
end architecture Behavioral;