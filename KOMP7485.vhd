library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity KOMP7485 is
	port(	A, B: in unsigned(3 downto 0);
			IKL, IGL, IGR: in bit;
			KL, GL, GR: out bit);
end KOMP7485;

architecture ARCH1 of KOMP7485 is
signal TEMP: bit_vector(2 downto 0);
begin
P1: process(A, B, IKL, IGL, IGR)
	begin
		if A>B then TEMP <= "100";
		elsif A<B then  TEMP <= "001";
		elsif IGR = '1' and IGL = '0' and IKL = '0' then  TEMP <= "100";
		elsif IGR = '0' and IGL = '0' and IKL = '1' then  TEMP <= "001";
		elsif IGL = '1' then TEMP <= "010";
		elsif IGR = '1' and IGL = '0' and IKL = '1' then TEMP <= "000";
		else TEMP <= "101";
		end if;
	end process P1;

	GR <= TEMP(2);
	GL <= TEMP(1);
	KL <= TEMP(0);
end ARCH1;
