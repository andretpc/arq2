library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

entity aes128 is
  
	port (
		Key  : in  Matrix;
		In_Text  : in  Matrix;
		Out_CipherText : out Matrix);
		
end entity aes128;

architecture Behavioral of aes128 is
-----------------------------------------------------------------------------
-- Signals
-----------------------------------------------------------------------------

signal keyExpansion_D : matrixArray;
signal subStates : matrixArray;
signal mixStates : matrixArray;
signal addKeyStates : matrixArray;
signal shiftRowStates : matrixArray;

-----------------------------------------------------------------------------
-- Component instantiations
-----------------------------------------------------------------------------
component keyExpansion is
    port (
		In_Key  : in  Matrix;
		Out_KeyExpansion : out matrixArray);
  end component keyExpansion;
  
 component mixColumn is
    port (
		In_DI  : in  Matrix;
		Out_DO : out Matrix);
  end component mixColumn;
  
 component subBytes is
    port (
		In_State  : in  Matrix;
		Out_State : out Matrix);
  end component subBytes;
  
 component addRoundKey  is
    port (
		In_State  	: in  Matrix;
		In_RoundKey : in Matrix;
		Out_State	: out Matrix);
  end component addRoundKey ;
  
 begin
 -- round 0
	keyExpansion_1 : keyExpansion
		port map (
		  In_Key       => Key,
		  Out_KeyExpansion    => keyExpansion_D);
	  
	round0 : addRoundKey
		port map (
			In_State  	=> In_Text,
			In_RoundKey => Key,
			Out_State	=> addKeyStates(0));
-- round 1
			
	round1sub : subBytes
		port map (
			In_State  	=> addKeyStates(0),
			Out_State	=> subStates(0));
	
	shiftRowStates(0) <= shift_rows(subStates(0));
			
	round1mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(0),
			Out_DO	=> mixStates(0));
			
	round1addkey : addRoundKey
		port map (
			In_State  	=> mixStates(0),
			In_RoundKey	=> keyExpansion_D(1),
			Out_State	=> addKeyStates(1));
			
-- round 2
	round2sub : subBytes
		port map (
			In_State  	=> addKeyStates(1),
			Out_State	=> subStates(1));
	
	shiftRowStates(1) <= shift_rows(subStates(1));
			
	round2mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(1),
			Out_DO	=> mixStates(1));
			
	round2addkey : addRoundKey
		port map (
			In_State  	=> mixStates(1),
			In_RoundKey	=> keyExpansion_D(2),
			Out_State	=> addKeyStates(2));
-- round 3
	round3sub : subBytes
		port map (
			In_State  	=> addKeyStates(2),
			Out_State	=> subStates(2));
	
	shiftRowStates(2) <= shift_rows(subStates(2));
			
	round3mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(2),
			Out_DO	=> mixStates(2));
			
	round3addkey : addRoundKey
		port map (
			In_State  	=> mixStates(2),
			In_RoundKey	=> keyExpansion_D(3),
			Out_State	=> addKeyStates(3));
-- round 4
	round4sub : subBytes
		port map (
			In_State  	=> addKeyStates(3),
			Out_State	=> subStates(3));
	
	shiftRowStates(3) <= shift_rows(subStates(3));
			
	round4mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(3),
			Out_DO	=> mixStates(3));
			
	round4addkey : addRoundKey
		port map (
			In_State  	=> mixStates(3),
			In_RoundKey	=> keyExpansion_D(4),
			Out_State	=> addKeyStates(4));
-- round 5
	round5sub : subBytes
		port map (
			In_State  	=> addKeyStates(4),
			Out_State	=> subStates(4));
	
	shiftRowStates(4) <= shift_rows(subStates(4));
			
	round5mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(4),
			Out_DO	=> mixStates(4));
			
	round5addkey : addRoundKey
		port map (
			In_State  	=> mixStates(4),
			In_RoundKey	=> keyExpansion_D(5),
			Out_State	=> addKeyStates(5));
-- round 6
	round6sub : subBytes
		port map (
			In_State  	=> addKeyStates(5),
			Out_State	=> subStates(5));
	
	shiftRowStates(5) <= shift_rows(subStates(5));
			
	round6mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(5),
			Out_DO	=> mixStates(5));
			
	round6addkey : addRoundKey
		port map (
			In_State  	=> mixStates(5),
			In_RoundKey	=> keyExpansion_D(6),
			Out_State	=> addKeyStates(6));
-- round 7
	round7sub : subBytes
		port map (
			In_State  	=> addKeyStates(6),
			Out_State	=> subStates(6));
	
	shiftRowStates(6) <= shift_rows(subStates(6));
			
	round7mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(6),
			Out_DO	=> mixStates(6));
			
	round7addkey : addRoundKey
		port map (
			In_State  	=> mixStates(6),
			In_RoundKey	=> keyExpansion_D(7),
			Out_State	=> addKeyStates(7));
-- round 8
	round8sub : subBytes
		port map (
			In_State  	=> addKeyStates(7),
			Out_State	=> subStates(7));
	
	shiftRowStates(7) <= shift_rows(subStates(7));
			
	round8mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(7),
			Out_DO	=> mixStates(7));
			
	round8addkey : addRoundKey
		port map (
			In_State  	=> mixStates(7),
			In_RoundKey	=> keyExpansion_D(8),
			Out_State	=> addKeyStates(8));
-- round 9
	round9sub : subBytes
		port map (
			In_State  	=> addKeyStates(8),
			Out_State	=> subStates(8));
	
	shiftRowStates(8) <= shift_rows(subStates(8));
			
	round9mix : mixColumn
		port map (
			In_DI  	=> shiftRowStates(8),
			Out_DO	=> mixStates(8));
			
	round9addkey : addRoundKey
		port map (
			In_State  	=> mixStates(8),
			In_RoundKey	=> keyExpansion_D(9),
			Out_State	=> addKeyStates(9));
-- round 10
	round10sub : subBytes
		port map (
			In_State  	=> addKeyStates(9),
			Out_State	=> subStates(9));
	
	shiftRowStates(9) <= shift_rows(subStates(9));
			
	round10addkey : addRoundKey
		port map (
			In_State  	=> shiftRowStates(9),
			In_RoundKey	=> keyExpansion_D(10),
			Out_State	=> Out_CipherText);
end architecture Behavioral;
