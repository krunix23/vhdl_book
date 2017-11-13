entity PARITAET1 is
	port(	D_IN, CLK: in bit;
		STARTBIT, STOPBIT: boolean;
		D_OUT: out bit);
end PARITAET1;

architecture VERHALTEN of PARITAET1 is
begin
P1: process
	variable PAR: boolean;
	begin
	wait until (CLK'event and CLK='1');
	if STARTBIT then
		PAR := false;
		while not STOPBIT loop
			D_OUT <= D_IN;
			if D_IN ='1' then
				PAR := not PAR;
			end if;
			wait until (CLK'event and CLK='1');
		end loop;
	end if;
	if PAR then
		D_OUT <= '1';
	else
		D_OUT <= '0';
	end if;
	end process P1;
end VERHALTEN;

entity PARITAET1_TEST is
end PARITAET1_TEST;

architecture VERHALTEN of PARITAET1_TEST is
	signal D_IN1, CLK1: bit;
	signal STARTBIT1: boolean;
	signal STOPBIT1: boolean;
	signal D_OUT1: bit;

component PARITAET1
	port(	D_IN, CLK: in bit;
		STARTBIT, STOPBIT: boolean;
		D_OUT: out bit);
end component;

for all: PARITAET1 use entity work.PARITAET1(VERHALTEN);
begin
	CLK1 <= '0', '1' after 50 ps, '0' after 100 ps, '1' after 150 ps, '0' after 200 ps, '1' after 250 ps, '0' after 300 ps, '1' after 350 ps, '0' after 400 ps,
		 '1' after 450 ps, '0' after 500 ps, '1' after 550 ps, '0' after 600 ps, '1' after 650 ps, '0' after 700 ps, '1' after 750 ps, '0' after 800 ps;
	D_IN1 <= '0', '1' after 100 ps, '0' after 300 ps, '1' after 400 ps, '0' after 500 ps;
	STARTBIT1 <= false, true after 100 ps, false after 200 ps;
	STOPBIT1 <= false, true after 600 ps, false after 700 ps;
C1: PARITAET1 port map(D_IN1, CLK1, STARTBIT1, STOPBIT1, D_OUT1);
end VERHALTEN;