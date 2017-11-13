entity PARITAET is
	generic(	BITS: integer := 4);
	port(		D: in bit_vector(BITS-1 downto 0);
			GERADE: out bit);
end PARITAET;

architecture VERHALTEN of PARITAET is
begin
PARGEN: process(D)
variable PAR: boolean;
begin
	PAR := false;
	for I in BITS-1 downto 0 loop
		if D(I) = '1' then
			PAR := not PAR;
		end if;
	end loop;
	if PAR then GERADE <= '1';
	else GERADE <= '0';
	end if;
	end process PARGEN;
end VERHALTEN;
