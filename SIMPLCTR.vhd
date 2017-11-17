library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SIMPLCTR is
	port(	CLK: in bit;
			Q: out unsigned(1 downto 0));
end SIMPLCTR;

architecture ARCH1 of SIMPLCTR is
signal QINT: unsigned(1 downto 0) := (others => '0');
begin
CTR: process(CLK)
	begin
		if CLK='1' and CLK'event then
			QINT <= QINT + 1;
		end if;
	end process CTR;
	Q <= QINT;
end ARCH1;
