library ieee;
use ieee.std_logic_1164.all;
use work.aes128Pkg.all;
use IEEE.numeric_std.all;

entity keyExpansion is
  
	port (
		In_Key  : in  Matrix;
		Out_KeyExpansion : out matrixArray);

end entity keyExpansion;

architecture Behavioral of keyExpansion is
type rconArray is array (1 to 10) of Byte;
constant RCON : rconArray := ("00000001", "00000010", "00000100", "00001000", "00010000", "00100000", "01000000", "10000000", "00011011", "00110110");

constant sbox : ByteArray := (
		16#63#, 16#7C#, 16#77#, 16#7B#, 16#F2#, 16#6B#, 16#6F#, 16#C5#, 16#30#, 16#01#, 16#67#, 16#2B#, 16#FE#, 16#D7#, 16#AB#, 16#76#,
        16#CA#, 16#82#, 16#C9#, 16#7D#, 16#FA#, 16#59#, 16#47#, 16#F0#, 16#AD#, 16#D4#, 16#A2#, 16#AF#, 16#9C#, 16#A4#, 16#72#, 16#C0#,
        16#B7#, 16#FD#, 16#93#, 16#26#, 16#36#, 16#3F#, 16#F7#, 16#CC#, 16#34#, 16#A5#, 16#E5#, 16#F1#, 16#71#, 16#D8#, 16#31#, 16#15#,
        16#04#, 16#C7#, 16#23#, 16#C3#, 16#18#, 16#96#, 16#05#, 16#9A#, 16#07#, 16#12#, 16#80#, 16#E2#, 16#EB#, 16#27#, 16#B2#, 16#75#,
        16#09#, 16#83#, 16#2C#, 16#1A#, 16#1B#, 16#6E#, 16#5A#, 16#A0#, 16#52#, 16#3B#, 16#D6#, 16#B3#, 16#29#, 16#E3#, 16#2F#, 16#84#,
        16#53#, 16#D1#, 16#00#, 16#ED#, 16#20#, 16#FC#, 16#B1#, 16#5B#, 16#6A#, 16#CB#, 16#BE#, 16#39#, 16#4A#, 16#4C#, 16#58#, 16#CF#,
        16#D0#, 16#EF#, 16#AA#, 16#FB#, 16#43#, 16#4D#, 16#33#, 16#85#, 16#45#, 16#F9#, 16#02#, 16#7F#, 16#50#, 16#3C#, 16#9F#, 16#A8#,
        16#51#, 16#A3#, 16#40#, 16#8F#, 16#92#, 16#9D#, 16#38#, 16#F5#, 16#BC#, 16#B6#, 16#DA#, 16#21#, 16#10#, 16#FF#, 16#F3#, 16#D2#,
        16#CD#, 16#0C#, 16#13#, 16#EC#, 16#5F#, 16#97#, 16#44#, 16#17#, 16#C4#, 16#A7#, 16#7E#, 16#3D#, 16#64#, 16#5D#, 16#19#, 16#73#,
        16#60#, 16#81#, 16#4F#, 16#DC#, 16#22#, 16#2A#, 16#90#, 16#88#, 16#46#, 16#EE#, 16#B8#, 16#14#, 16#DE#, 16#5E#, 16#0B#, 16#DB#,
        16#E0#, 16#32#, 16#3A#, 16#0A#, 16#49#, 16#06#, 16#24#, 16#5C#, 16#C2#, 16#D3#, 16#AC#, 16#62#, 16#91#, 16#95#, 16#E4#, 16#79#,
        16#E7#, 16#C8#, 16#37#, 16#6D#, 16#8D#, 16#D5#, 16#4E#, 16#A9#, 16#6C#, 16#56#, 16#F4#, 16#EA#, 16#65#, 16#7A#, 16#AE#, 16#08#,
        16#BA#, 16#78#, 16#25#, 16#2E#, 16#1C#, 16#A6#, 16#B4#, 16#C6#, 16#E8#, 16#DD#, 16#74#, 16#1F#, 16#4B#, 16#BD#, 16#8B#, 16#8A#,
        16#70#, 16#3E#, 16#B5#, 16#66#, 16#48#, 16#03#, 16#F6#, 16#0E#, 16#61#, 16#35#, 16#57#, 16#B9#, 16#86#, 16#C1#, 16#1D#, 16#9E#,
        16#E1#, 16#F8#, 16#98#, 16#11#, 16#69#, 16#D9#, 16#8E#, 16#94#, 16#9B#, 16#1E#, 16#87#, 16#E9#, 16#CE#, 16#55#, 16#28#, 16#DF#,
        16#8C#, 16#A1#, 16#89#, 16#0D#, 16#BF#, 16#E6#, 16#42#, 16#68#, 16#41#, 16#99#, 16#2D#, 16#0F#, 16#B0#, 16#54#, 16#BB#, 16#16#);

signal keyExpansion_D : matrixArray;

begin
	-- Round 1
	keyExpansion_D(0) <= In_Key;
	
	keyExpansion_D(1)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(In_Key(3)(1)))), 8)) xor RCON(1) xor In_Key(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(In_Key(3)(2)))), 8)) xor In_Key(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(In_Key(3)(3)))), 8)) xor In_Key(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(In_Key(3)(0)))), 8)) xor In_Key(0)(3));
							  
	keyExpansion_D(1)(1) <= (keyExpansion_D(1)(0)(0) xor In_Key(1)(0), 
							 keyExpansion_D(1)(0)(1) xor In_Key(1)(1), 
							 keyExpansion_D(1)(0)(2) xor In_Key(1)(2), 
							 keyExpansion_D(1)(0)(3) xor In_Key(1)(3));
				
	keyExpansion_D(1)(2) <= (keyExpansion_D(1)(1)(0) xor In_Key(2)(0), 
							 keyExpansion_D(1)(1)(1) xor In_Key(2)(1), 
							 keyExpansion_D(1)(1)(2) xor In_Key(2)(2), 
							 keyExpansion_D(1)(1)(3) xor In_Key(2)(3));
							 
	keyExpansion_D(1)(3) <= (keyExpansion_D(1)(2)(0) xor In_Key(3)(0), 
							 keyExpansion_D(1)(2)(1) xor In_Key(3)(1), 
							 keyExpansion_D(1)(2)(2) xor In_Key(3)(2), 
							 keyExpansion_D(1)(2)(3) xor In_Key(3)(3));
							 
	-- Round 2				 
	keyExpansion_D(2)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(1)(3)(1)))), 8)) xor RCON(2) xor keyExpansion_D(1)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(1)(3)(2)))), 8)) xor keyExpansion_D(1)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(1)(3)(3)))), 8)) xor keyExpansion_D(1)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(1)(3)(0)))), 8)) xor keyExpansion_D(1)(0)(3));
								  
	keyExpansion_D(2)(1) <= (keyExpansion_D(2)(0)(0) xor keyExpansion_D(1)(1)(0), 
							 keyExpansion_D(2)(0)(1) xor keyExpansion_D(1)(1)(1), 
							 keyExpansion_D(2)(0)(2) xor keyExpansion_D(1)(1)(2), 
							 keyExpansion_D(2)(0)(3) xor keyExpansion_D(1)(1)(3));
	
	keyExpansion_D(2)(2) <= (keyExpansion_D(2)(1)(0) xor keyExpansion_D(1)(2)(0), 
							 keyExpansion_D(2)(1)(1) xor keyExpansion_D(1)(2)(1), 
							 keyExpansion_D(2)(1)(2) xor keyExpansion_D(1)(2)(2), 
							 keyExpansion_D(2)(1)(3) xor keyExpansion_D(1)(2)(3));
							 
	keyExpansion_D(2)(3) <= (keyExpansion_D(2)(2)(0) xor keyExpansion_D(1)(3)(0), 
							 keyExpansion_D(2)(2)(1) xor keyExpansion_D(1)(3)(1), 
							 keyExpansion_D(2)(2)(2) xor keyExpansion_D(1)(3)(2), 
							 keyExpansion_D(2)(2)(3) xor keyExpansion_D(1)(3)(3));
	
	-- Round 3						 
	keyExpansion_D(3)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(2)(3)(1)))), 8)) xor RCON(3) xor keyExpansion_D(2)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(2)(3)(2)))), 8)) xor keyExpansion_D(2)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(2)(3)(3)))), 8)) xor keyExpansion_D(2)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(2)(3)(0)))), 8)) xor keyExpansion_D(2)(0)(3));
								  
	keyExpansion_D(3)(1) <= (keyExpansion_D(3)(0)(0) xor keyExpansion_D(2)(1)(0), 
							 keyExpansion_D(3)(0)(1) xor keyExpansion_D(2)(1)(1), 
							 keyExpansion_D(3)(0)(2) xor keyExpansion_D(2)(1)(2), 
							 keyExpansion_D(3)(0)(3) xor keyExpansion_D(2)(1)(3));
	
	keyExpansion_D(3)(2) <= (keyExpansion_D(3)(1)(0) xor keyExpansion_D(2)(2)(0), 
							 keyExpansion_D(3)(1)(1) xor keyExpansion_D(2)(2)(1), 
							 keyExpansion_D(3)(1)(2) xor keyExpansion_D(2)(2)(2), 
							 keyExpansion_D(3)(1)(3) xor keyExpansion_D(2)(2)(3));
							 
	keyExpansion_D(3)(3) <= (keyExpansion_D(3)(2)(0) xor keyExpansion_D(2)(3)(0), 
							 keyExpansion_D(3)(2)(1) xor keyExpansion_D(2)(3)(1), 
							 keyExpansion_D(3)(2)(2) xor keyExpansion_D(2)(3)(2), 
							 keyExpansion_D(3)(2)(3) xor keyExpansion_D(2)(3)(3));
							 
	-- Round 4						 
	keyExpansion_D(4)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(3)(3)(1)))), 8)) xor RCON(4) xor keyExpansion_D(3)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(3)(3)(2)))), 8)) xor keyExpansion_D(3)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(3)(3)(3)))), 8)) xor keyExpansion_D(3)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(3)(3)(0)))), 8)) xor keyExpansion_D(3)(0)(3));
								  
	keyExpansion_D(4)(1) <= (keyExpansion_D(4)(0)(0) xor keyExpansion_D(3)(1)(0), 
							 keyExpansion_D(4)(0)(1) xor keyExpansion_D(3)(1)(1), 
							 keyExpansion_D(4)(0)(2) xor keyExpansion_D(3)(1)(2), 
							 keyExpansion_D(4)(0)(3) xor keyExpansion_D(3)(1)(3));
	
	keyExpansion_D(4)(2) <= (keyExpansion_D(4)(1)(0) xor keyExpansion_D(3)(2)(0), 
							 keyExpansion_D(4)(1)(1) xor keyExpansion_D(3)(2)(1), 
							 keyExpansion_D(4)(1)(2) xor keyExpansion_D(3)(2)(2), 
							 keyExpansion_D(4)(1)(3) xor keyExpansion_D(3)(2)(3));
							 
	keyExpansion_D(4)(3) <= (keyExpansion_D(4)(2)(0) xor keyExpansion_D(3)(3)(0), 
							 keyExpansion_D(4)(2)(1) xor keyExpansion_D(3)(3)(1), 
							 keyExpansion_D(4)(2)(2) xor keyExpansion_D(3)(3)(2), 
							 keyExpansion_D(4)(2)(3) xor keyExpansion_D(3)(3)(3));
	-- Round 5						 
	keyExpansion_D(5)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(4)(3)(1)))), 8)) xor RCON(5) xor keyExpansion_D(4)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(4)(3)(2)))), 8)) xor keyExpansion_D(4)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(4)(3)(3)))), 8)) xor keyExpansion_D(4)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(4)(3)(0)))), 8)) xor keyExpansion_D(4)(0)(3));
								  
	keyExpansion_D(5)(1) <= (keyExpansion_D(5)(0)(0) xor keyExpansion_D(4)(1)(0), 
							 keyExpansion_D(5)(0)(1) xor keyExpansion_D(4)(1)(1), 
							 keyExpansion_D(5)(0)(2) xor keyExpansion_D(4)(1)(2), 
							 keyExpansion_D(5)(0)(3) xor keyExpansion_D(4)(1)(3));
	
	keyExpansion_D(5)(2) <= (keyExpansion_D(5)(1)(0) xor keyExpansion_D(4)(2)(0), 
							 keyExpansion_D(5)(1)(1) xor keyExpansion_D(4)(2)(1), 
							 keyExpansion_D(5)(1)(2) xor keyExpansion_D(4)(2)(2), 
							 keyExpansion_D(5)(1)(3) xor keyExpansion_D(4)(2)(3));
							 
	keyExpansion_D(5)(3) <= (keyExpansion_D(5)(2)(0) xor keyExpansion_D(4)(3)(0), 
							 keyExpansion_D(5)(2)(1) xor keyExpansion_D(4)(3)(1), 
							 keyExpansion_D(5)(2)(2) xor keyExpansion_D(4)(3)(2), 
							 keyExpansion_D(5)(2)(3) xor keyExpansion_D(4)(3)(3));
	-- Round 6						 
	keyExpansion_D(6)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(5)(3)(1)))), 8)) xor RCON(6) xor keyExpansion_D(5)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(5)(3)(2)))), 8)) xor keyExpansion_D(5)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(5)(3)(3)))), 8)) xor keyExpansion_D(5)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(5)(3)(0)))), 8)) xor keyExpansion_D(5)(0)(3));
								  
	keyExpansion_D(6)(1) <= (keyExpansion_D(6)(0)(0) xor keyExpansion_D(5)(1)(0), 
							 keyExpansion_D(6)(0)(1) xor keyExpansion_D(5)(1)(1), 
							 keyExpansion_D(6)(0)(2) xor keyExpansion_D(5)(1)(2), 
							 keyExpansion_D(6)(0)(3) xor keyExpansion_D(5)(1)(3));
	
	keyExpansion_D(6)(2) <= (keyExpansion_D(6)(1)(0) xor keyExpansion_D(5)(2)(0), 
							 keyExpansion_D(6)(1)(1) xor keyExpansion_D(5)(2)(1), 
							 keyExpansion_D(6)(1)(2) xor keyExpansion_D(5)(2)(2), 
							 keyExpansion_D(6)(1)(3) xor keyExpansion_D(5)(2)(3));
							 
	keyExpansion_D(6)(3) <= (keyExpansion_D(6)(2)(0) xor keyExpansion_D(5)(3)(0), 
							 keyExpansion_D(6)(2)(1) xor keyExpansion_D(5)(3)(1), 
							 keyExpansion_D(6)(2)(2) xor keyExpansion_D(5)(3)(2), 
							 keyExpansion_D(6)(2)(3) xor keyExpansion_D(5)(3)(3));
	-- Round 7						 
	keyExpansion_D(7)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(6)(3)(1)))), 8)) xor RCON(7) xor keyExpansion_D(6)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(6)(3)(2)))), 8)) xor keyExpansion_D(6)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(6)(3)(3)))), 8)) xor keyExpansion_D(6)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(6)(3)(0)))), 8)) xor keyExpansion_D(6)(0)(3));
								  
	keyExpansion_D(7)(1) <= (keyExpansion_D(7)(0)(0) xor keyExpansion_D(6)(1)(0), 
							 keyExpansion_D(7)(0)(1) xor keyExpansion_D(6)(1)(1), 
							 keyExpansion_D(7)(0)(2) xor keyExpansion_D(6)(1)(2), 
							 keyExpansion_D(7)(0)(3) xor keyExpansion_D(6)(1)(3));
	
	keyExpansion_D(7)(2) <= (keyExpansion_D(7)(1)(0) xor keyExpansion_D(6)(2)(0), 
							 keyExpansion_D(7)(1)(1) xor keyExpansion_D(6)(2)(1), 
							 keyExpansion_D(7)(1)(2) xor keyExpansion_D(6)(2)(2), 
							 keyExpansion_D(7)(1)(3) xor keyExpansion_D(6)(2)(3));
							 
	keyExpansion_D(7)(3) <= (keyExpansion_D(7)(2)(0) xor keyExpansion_D(6)(3)(0), 
							 keyExpansion_D(7)(2)(1) xor keyExpansion_D(6)(3)(1), 
							 keyExpansion_D(7)(2)(2) xor keyExpansion_D(6)(3)(2), 
							 keyExpansion_D(7)(2)(3) xor keyExpansion_D(6)(3)(3));
	-- Round 8						 
	keyExpansion_D(8)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(7)(3)(1)))), 8)) xor RCON(8) xor keyExpansion_D(7)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(7)(3)(2)))), 8)) xor keyExpansion_D(7)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(7)(3)(3)))), 8)) xor keyExpansion_D(7)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(7)(3)(0)))), 8)) xor keyExpansion_D(7)(0)(3));
								  
	keyExpansion_D(8)(1) <= (keyExpansion_D(8)(0)(0) xor keyExpansion_D(7)(1)(0), 
							 keyExpansion_D(8)(0)(1) xor keyExpansion_D(7)(1)(1), 
							 keyExpansion_D(8)(0)(2) xor keyExpansion_D(7)(1)(2), 
							 keyExpansion_D(8)(0)(3) xor keyExpansion_D(7)(1)(3));
	
	keyExpansion_D(8)(2) <= (keyExpansion_D(8)(1)(0) xor keyExpansion_D(7)(2)(0), 
							 keyExpansion_D(8)(1)(1) xor keyExpansion_D(7)(2)(1), 
							 keyExpansion_D(8)(1)(2) xor keyExpansion_D(7)(2)(2), 
							 keyExpansion_D(8)(1)(3) xor keyExpansion_D(7)(2)(3));
							 
	keyExpansion_D(8)(3) <= (keyExpansion_D(8)(2)(0) xor keyExpansion_D(7)(3)(0), 
							 keyExpansion_D(8)(2)(1) xor keyExpansion_D(7)(3)(1), 
							 keyExpansion_D(8)(2)(2) xor keyExpansion_D(7)(3)(2), 
							 keyExpansion_D(8)(2)(3) xor keyExpansion_D(7)(3)(3));
	-- Round 9						 
	keyExpansion_D(9)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(8)(3)(1)))), 8)) xor RCON(9) xor keyExpansion_D(8)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(8)(3)(2)))), 8)) xor keyExpansion_D(8)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(8)(3)(3)))), 8)) xor keyExpansion_D(8)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(8)(3)(0)))), 8)) xor keyExpansion_D(8)(0)(3));
								  
	keyExpansion_D(9)(1) <= (keyExpansion_D(9)(0)(0) xor keyExpansion_D(8)(1)(0), 
							 keyExpansion_D(9)(0)(1) xor keyExpansion_D(8)(1)(1), 
							 keyExpansion_D(9)(0)(2) xor keyExpansion_D(8)(1)(2), 
							 keyExpansion_D(9)(0)(3) xor keyExpansion_D(8)(1)(3));
	
	keyExpansion_D(9)(2) <= (keyExpansion_D(9)(1)(0) xor keyExpansion_D(8)(2)(0), 
							 keyExpansion_D(9)(1)(1) xor keyExpansion_D(8)(2)(1), 
							 keyExpansion_D(9)(1)(2) xor keyExpansion_D(8)(2)(2), 
							 keyExpansion_D(9)(1)(3) xor keyExpansion_D(8)(2)(3));
							 
	keyExpansion_D(9)(3) <= (keyExpansion_D(9)(2)(0) xor keyExpansion_D(8)(3)(0), 
							 keyExpansion_D(9)(2)(1) xor keyExpansion_D(8)(3)(1), 
							 keyExpansion_D(9)(2)(2) xor keyExpansion_D(8)(3)(2), 
							 keyExpansion_D(9)(2)(3) xor keyExpansion_D(8)(3)(3));
	-- Round 10						 
	keyExpansion_D(10)(0) <= (std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(9)(3)(1)))), 8)) xor RCON(10) xor keyExpansion_D(9)(0)(0), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(9)(3)(2)))), 8)) xor keyExpansion_D(9)(0)(1), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(9)(3)(3)))), 8)) xor keyExpansion_D(9)(0)(2), 
							 std_logic_vector(to_unsigned(sbox(to_integer(unsigned(keyExpansion_D(9)(3)(0)))), 8)) xor keyExpansion_D(9)(0)(3));
								  
	keyExpansion_D(10)(1) <= (keyExpansion_D(10)(0)(0) xor keyExpansion_D(9)(1)(0), 
							 keyExpansion_D(10)(0)(1) xor keyExpansion_D(9)(1)(1), 
							 keyExpansion_D(10)(0)(2) xor keyExpansion_D(9)(1)(2), 
							 keyExpansion_D(10)(0)(3) xor keyExpansion_D(9)(1)(3));
	
	keyExpansion_D(10)(2) <= (keyExpansion_D(10)(1)(0) xor keyExpansion_D(9)(2)(0), 
							 keyExpansion_D(10)(1)(1) xor keyExpansion_D(9)(2)(1), 
							 keyExpansion_D(10)(1)(2) xor keyExpansion_D(9)(2)(2), 
							 keyExpansion_D(10)(1)(3) xor keyExpansion_D(9)(2)(3));
							 
	keyExpansion_D(10)(3) <= (keyExpansion_D(10)(2)(0) xor keyExpansion_D(9)(3)(0), 
							 keyExpansion_D(10)(2)(1) xor keyExpansion_D(9)(3)(1), 
							 keyExpansion_D(10)(2)(2) xor keyExpansion_D(9)(3)(2), 
							 keyExpansion_D(10)(2)(3) xor keyExpansion_D(9)(3)(3));
	
							  
	Out_KeyExpansion <= keyExpansion_D;
end architecture Behavioral;
	
			