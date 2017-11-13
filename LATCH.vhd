entity LATCH is
	port(	D, CLK: in bit;
		Q: buffer bit);
end LATCH;

architecture LATCH1 of LATCH is
begin
	Q <= D when CLK ='1' else Q;
end LATCH1;

architecture LATCH2 of LATCH is
begin
	with CLK select
	Q <=	D when '1',
		Q when others;
end LATCH2;
