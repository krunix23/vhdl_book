library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLD_CELL is
	port(	PROD_TERM, CLK, RESET: in bit;
			S: in bit_vector(2 downto 0);
			IO_PAD: inout std_logic;
			FEEDBACK: out bit);
end PLD_CELL;

architecture ARCH1 of PLD_CELL is
signal TEMP1, TEMP2, TEMP3: bit;
begin

	TEMP1 <= S(2) xor PROD_TERM;

FF: process(RESET, CLK)
begin
	if RESET = '1' then
		TEMP2 <= '0';
	elsif CLK = '1' and CLK'event then
		TEMP2 <= TEMP1;
	end if;
end process FF;

	TEMP3 <= TEMP1 when S(1) = '0' else TEMP2;

	IO_PAD <= TO_StdULogic(TEMP3) when S(0) = '1' else 'Z';

	FEEDBACK <= To_Bit(IO_PAD);

end ARCH1;
