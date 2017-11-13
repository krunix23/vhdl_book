entity PARGEN is
	port(	A, B, C: in bit;
			P_O: out bit);
end PARGEN;

architecture ARCH1 of PARGEN is
begin
PARPROC: process(A, B, C)
variable D: bit_vector(2 downto 0);
begin
	D :=  A & B & C;
	case D is
		when "000" => P_O <= '1';
		when "011" => P_O <= '1';
		when "101" => P_O <= '1';
		when "110" => P_O <= '1';
		when others => P_O <= '0';
	end case;
end process PARPROC;
end ARCH1;

--##############################################
entity PARGEN_TB is
end PARGEN_TB;

architecture VERHALTEN of PARGEN_TB is

component PARGEN is
	port(	A, B, C: in bit;
			P_O: out bit);
end component;

signal A, B, C, P_O: bit;
signal YINT: bit_vector(2 downto 0);

begin
-- Stimulus
B <= '0', '1' after 200 ns, '0' after 400 ns, '1' after 600 ns;
C <= '0', '1' after 400 ns;

TAKTGEN: process
begin
	A <= '0';
	wait for 100 ns;
	A <= '1';
	wait for 100 ns;
end process TAKTGEN;

YINT <= A & B & C;

DUT: PARGEN port map(A, B, C, P_O);

CHECK: process
begin
	wait for 50 ns;
	assert P_O = '1' report "ERR: test# 0";
	wait for 100 ns;
	assert P_O = '0' report "ERR: test# 1";
	wait for 100 ns;
	assert P_O = '0' report "ERR: test# 2";
	wait for 100 ns;
	assert P_O = '1' report "ERR: test# 3";
	wait for 100 ns;
	assert P_O = '0' report "ERR: test# 4";
	wait for 100 ns;
	assert P_O = '1' report "ERR: test# 5";
	wait for 100 ns;
	assert P_O = '1' report "ERR: test# 6";
	wait for 100 ns;
	assert P_O = '1' report "ERR: test# 7"; -- falsche Erwartung
	wait for 100 ns;
end process CHECK;
end VERHALTEN;

