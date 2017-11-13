library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BUSDRIVER is
	port(	ENABLE: in bit;
			I_O: inout std_logic_vector(7 downto 0);
			OUT_I: in std_ulogic_vector(7 downto 0);
			IN_I: out std_ulogic_vector(7 downto 0));
end BUSDRIVER;

architecture ARCH1 of BUSDRIVER is
begin
WRITE: process(ENABLE, OUT_I)
	begin
		if ENABLE = '1' then I_O <= To_StdLogicVector(OUT_I);
		else I_O <= (others => 'Z');
		end if;
	end process WRITE;
READ: IN_I <= To_StdULogicVector(I_O);
end ARCH1;
