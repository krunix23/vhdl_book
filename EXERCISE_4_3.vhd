library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX_1X4 is
	port(	SEL: in bit_vector(1 downto 0);
			EN, D: in bit;
			Y: out std_logic_vector(3 downto 0));
end DEMUX_1X4;

architecture ARCH1 of DEMUX_1X4 is
signal Y0, Y1, Y2, Y3: std_logic;
begin
P1: process(SEL, D)
begin
	Y0 <= 'Z';
	Y1 <= 'Z';
	Y2 <= 'Z';
	Y3 <= 'Z';
	case SEL is
		when "00" => Y0 <= To_StdULogic(D);
		when "01" => Y1 <= To_StdULogic(D);
		when "10" => Y2 <= To_StdULogic(D);
		when "11" => Y3 <= To_StdULogic(D);
		when others => report "unreachable" severity failure;
	end case;
	end process P1;
	Y <= "ZZZZ" when EN = '0' else Y3 & Y2 & Y1 & Y0;
end ARCH1;
