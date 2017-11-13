entity REG_GEN is
	generic( N: integer := 16);
	port(	CLK, RESET: in bit;
			D: in bit_vector(N-1 downto 0);
			Q: out bit_vector(N-1 downto 0));
end REG_GEN;

architecture VERHALTEN of REG_GEN is
begin
REG: process(CLK, RESET)
begin
	if RESET = '1' then
		Q <= (others => '0');
	elsif CLK = '0' and CLK'event then
		Q <= D;
	end if;
	end process REG;
end VERHALTEN;
