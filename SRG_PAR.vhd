entity SRG_PAR is
	generic(	WIDTH: natural := 4;
				SHW: natural := 2);
	port(	CLK, LOAD, R_L: in bit;
			DIN: in bit_vector(WIDTH-1 downto 0);
			YOUT: out bit_vector(WIDTH-1 downto 0));
end SRG_PAR;

architecture SHIFT_R_L of SRG_PAR is
signal YINT: bit_vector(WIDTH-1 downto 0);
signal TEMP: bit_vector(SHW-1 downto 0);
begin
TEMP <= (others => '0');
P1: process(CLK)
begin
	if CLK='1' and CLK'event then
		if LOAD='1' then YINT <= DIN;
		elsif R_L='0' then
			YINT <= YINT(WIDTH-1-SHW downto 0) & TEMP;
		else
			YINT <= TEMP & YINT(WIDTH-1 downto SHW);
		end if;
	end if;
	end process P1;
YOUT <= YINT;
end SHIFT_R_L;
