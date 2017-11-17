--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity ZAHELER is
	generic( BITS: natural := 3);
	port(	CLK, RESET: in bit;
			Q: out integer range 0 to 2**BITS-1);
end ZAHELER;

architecture ARCH1 of ZAHELER is
signal TEMP: integer range 0 to 2**BITS-1;
begin
CTR: process(CLK, RESET)
	begin
	if RESET = '1' then
		TEMP <= 0;
	elsif CLK = '1' and CLK'event then
		TEMP <= (TEMP + 1) mod 2**BITS;
	end if;
	end process CTR;
	Q <= TEMP;
end ARCH1;
