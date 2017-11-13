entity OLMC is
	port(	CLK, I:	in bit;
		S:	in bit_vector(1 downto 0);
		Y:	out bit);
end OLMC;

architecture ARCH1 of OLMC is
signal TEMP1, TEMP2: bit;
begin
MUX: process(I, TEMP1, S(0))
	begin
		TEMP2 <= (I and not S(0)) or (TEMP1 and S(0));
	end process MUX;
FF: process
	begin
		wait until CLK='1' and CLK'event;
		TEMP1 <= I;
	end process FF;
	Y <= TEMP2 xor S(1);
end ARCH1;
