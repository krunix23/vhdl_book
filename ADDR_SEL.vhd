library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDR_SEL is
	port(	ENABLE: in bit;
			INP: in std_logic;
			ADR: in bit_vector(1 downto 0);
			Q: out std_logic_vector(3 downto 0));
end ADDR_SEL;

architecture ARCH1 of ADDR_SEL is
begin
P1: process(ENABLE, ADR, INP)
	variable ADR_VAR: integer range 0 to 7;
	begin
		Q <= (others => 'Z');
		ADR_VAR := To_Integer(unsigned(To_StdLogicVector(ADR)));
		if ENABLE = '1' then
			Q(ADR_VAR) <= INP;
		end if;
	end process P1;
end ARCH1;
