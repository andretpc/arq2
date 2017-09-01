library ieee;
use ieee.std_logic_1164.all;

package aes128Pkg is
	subtype Byte is std_logic_vector(7 downto 0);
	subtype ByteInt is integer range 16#00# to 16#FF#;
	type 	Word is array (0 to 3) of Byte;
	type 	ByteArray is array (0 to 255) of ByteInt;
	type 	Matrix is array (0 to 3) of Word;
	type 	matrixArray is array (0 to 10) of Matrix;
	function shift_rows(
    input : Matrix)
    return Matrix;
	end package aes128Pkg;
	package body aes128Pkg is
		function shift_rows (
		input : Matrix)
		return Matrix is
		variable result : Matrix;
		begin  -- function shift_rows

		-- First Row
		result(0)(0) := input(0)(0);
		result(1)(0) := input(1)(0);
		result(2)(0) := input(2)(0);
		result(3)(0) := input(3)(0);
		-- Second Row
		result(0)(1) := input(1)(1);
		result(1)(1) := input(2)(1);
		result(2)(1) := input(3)(1);
		result(3)(1) := input(0)(1);
		-- Third Row
		result(0)(2) := input(2)(2);
		result(1)(2) := input(3)(2);
		result(2)(2) := input(0)(2);
		result(3)(2) := input(1)(2);
		-- Fourth Row
		result(0)(3) := input(3)(3);
		result(1)(3) := input(0)(3);
		result(2)(3) := input(1)(3);
		result(3)(3) := input(2)(3);

		return result;
	  end function shift_rows;
	 end package body aes128Pkg;

library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

entity addRoundKey is
  
	port (
		In_State  	: in  Matrix;
		In_RoundKey : in Matrix;
		Out_State	: out Matrix);

end entity addRoundKey;

architecture Behavioral of addRoundKey is

signal Matrix_D : Matrix;
begin
	process (Matrix_D, In_State, In_RoundKey)
	begin
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			Matrix_D(i)(j) <= In_State(i)(j) xor In_RoundKey(i)(j);
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