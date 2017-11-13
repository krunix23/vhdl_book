library ieee;
use ieee.std_logic_1164.all;

entity DFF_EN_TSB is
	port(	CLK, RESET, ENABLE: in bit;
			D: in std_ulogic;
			Q: out std_ulogic);
end DFF_EN_TSB;

architecture ARCH2 of DFF_EN_TSB is
signal TEMP: std_ulogic;
begin
FF: process(CLK, RESET)
	begin
		if RESET = '1' then
			TEMP <= '0';
		elsif CLK = '1' and CLK'event then
			TEMP <= D;
		end if;
	end process FF;

TSB: process(TEMP, ENABLE)
	begin
		if ENABLE = '1' then
			Q <= TEMP;
		else
			Q <= 'Z';
		end if;
	end process TSB;
end ARCH2;
