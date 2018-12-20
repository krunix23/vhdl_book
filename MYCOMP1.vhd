library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MYCOMP1 is
	port(	clk     : in std_logic;
            reset_n : in  std_logic := 'X';
			q       : out std_logic_vector(7 downto 0));
end MYCOMP1;

architecture ARCH of MYCOMP1 is
signal QINT: unsigned(7 downto 0) := (others => '0');
begin
CTR: process(clk)
	begin
		if clk='1' and clk'event and reset_n = '1' then
			QINT <= QINT + 1;
		end if;
	end process CTR;
	q <= std_logic_vector(QINT);
end ARCH;
