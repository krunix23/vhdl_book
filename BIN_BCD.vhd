library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BIN_BCD is
	port(	E: in std_logic_vector(3 downto 0);
			A: out std_logic_vector(3 downto 0));
end BIN_BCD;

architecture TABELLE of BIN_BCD is
begin
P1: process(E)
begin
	case E is
		when x"0" => A <= x"0";
		when x"1" => A <= x"1";
		when x"2" => A <= x"2";
		when x"3" => A <= x"3";
		when x"4" => A <= x"4";
		when x"5" => A <= x"5";
		when x"6" => A <= x"6";
		when x"7" => A <= x"7";
		when x"8" => A <= x"8";
		when x"9" => A <= x"9";
		when others => A <= "----";
--		when others => A <= x"0";
--		when others => A <= x"f";
	end case;
	end process P1;
end TABELLE;
