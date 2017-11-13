entity TEST_PROCESS is
	port(	CLK: in bit;
		Q: out bit);
end TEST_PROCESS;

architecture VERHALTEN of TEST_PROCESS is
signal SIG: bit;
begin
P1: process(CLK)
	variable SIG_VAR: bit;
	begin
		SIG_VAR := '1';
		if SIG_VAR = '1' then
			SIG <= SIG_VAR;
			SIG_VAR := '0';
		end if;
	end process P1;
	Q <= SIG;
end VERHALTEN;
