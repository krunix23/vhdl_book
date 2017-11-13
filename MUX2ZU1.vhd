entity MUX2ZU1 is
	port(	I: in bit_vector(1 downto 0);
		S, E: in bit;
		Y: out bit);
end MUX2ZU1;

architecture MUX1 of MUX2ZU1 is
begin
	Y <= (I(0) and E and not S)
		or (I(1) and not E and S);
end MUX1;

architecture MUX2 of MUX2ZU1 is
begin
	with S select
	Y <=	(I(0) and not E) when '0',
		(I(1) and not E) when '1';
end MUX2;

architecture MUX3 of MUX2ZU1 is
begin
	Y <=	(I(0) and not E) when S='0' else
		(I(1) and not E);
end MUX3;		
