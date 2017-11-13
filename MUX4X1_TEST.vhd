entity MUX4X1_TEST is
end MUX4X1_TEST;

architecture VERHALTEN of MUX4X1_TEST is
	signal S1: bit_vector(1 downto 0);
	signal E1: bit_vector(3 downto 0);
	signal Y1: bit;

component MUX4X1
	port(	S: in bit_vector(1 downto 0);
		E: in bit_vector(3 downto 0);
		Y: out bit);
end component;

for all: MUX4X1 use entity work.MUX4X1(VERHALTEN);
begin
	E1 <= "0000", "0001" after 400 ps, "0010" after 800 ps, "0100" after 1200 ps, "1000" after 1600 ps;
	S1 <= "00", "01" after 100 ps, "10" after 200 ps, "11" after 300 ps, 
	      "00" after 400 ps, "01" after 500 ps, "10" after 600 ps, "11" after 700 ps,
	      "00" after 800 ps, "01" after 900 ps, "10" after 1000 ps, "11" after 1100 ps,
	      "00" after 1200 ps, "01" after 1300 ps, "10" after 1400 ps, "11" after 1500 ps,
	      "00" after 1600 ps, "01" after 1700 ps, "10" after 1800 ps, "11" after 1900 ps, "00" after 2000 ps;
C1: MUX4X1 port map(S1, E1, Y1);
end VERHALTEN;
