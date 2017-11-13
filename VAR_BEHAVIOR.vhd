entity VAR_BEHAVIOR is
	port(	A, B, C, CLK: in bit;
			Q1: out bit);

end VAR_BEHAVIOR;

architecture ARCH1 of VAR_BEHAVIOR is
begin
P1: process(CLK)
variable TEMP : bit;
	begin
		if CLK = '1' and CLK'event then
			TEMP := A and B;
			Q1 <= TEMP and C;
		end if;
	end process P1;
end ARCH1;

architecture ARCH2 of VAR_BEHAVIOR is
begin
P2: process(CLK)
variable TEMP : bit := '1';
	begin
		if CLK = '1' and CLK'event then
			TEMP := A and B;
			Q1 <= TEMP and C;
		end if;
	end process P2;
end ARCH2;

architecture ARCH3 of VAR_BEHAVIOR is
begin
P3: process(CLK)
variable TEMP : bit;
	begin
		if CLK = '1' and CLK'event then
			TEMP := A and B;
		end if;
		Q1 <= TEMP;
	end process P3;
end ARCH3;
