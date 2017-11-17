library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CTR74161 is
	generic( BITS: natural := 4 );
	port(	CLK, RESET, NLOAD, ENT, ENP: in bit;
			D: in unsigned(BITS-1 downto 0);
			Q: out unsigned(BITS-1 downto 0);
			TC: out bit);
end CTR74161;

architecture ARCH1 of CTR74161 is
signal QINT: unsigned(BITS-1 downto 0) := (others => '0');
begin
CTR: process(CLK, RESET)
	begin
		if RESET = '0' then
			QINT <= (others => '0');
		elsif CLK='1' and CLK'event then
			if NLOAD = '0' then
				QINT <= D;
			elsif ENT = '1' and ENP = '1' then
				QINT <= QINT + 1;
			end if;
		end if;
	end process CTR;
	TC <= '1' when (QINT = 2**BITS-1 and ENT = '1') else '0';
	Q <= QINT;
end ARCH1;
