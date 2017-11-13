entity DFF_R_EN is
	port(	CLK, RESET, ENABLE, D: in bit;
			Q: out bit);
end DFF_R_EN;

architecture VERHALTEN of DFF_R_EN is
begin
FF: process(CLK, RESET)
	begin
		if RESET = '1' then
			Q <= '0';
		elsif CLK = '1' and CLK'event then
			if ENABLE = '1' then
				Q <= D;
			end if;
		end if;
	end process FF;
end VERHALTEN;

-- ############## TESTBENCH ####################
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity DFF_R_EN_TEST is
end DFF_R_EN_TEST;

architecture VERHALTEN of DFF_R_EN_TEST is
	signal CLK1 : bit := '0';
	signal RESET1, ENABLE1, D1: bit;
	signal Q1: bit;

component DFF_R_EN
	port(	CLK, RESET, ENABLE, D: in bit;
			Q: out bit);
end component;

for all: DFF_R_EN use entity work.DFF_R_EN(VERHALTEN);
begin

CLKGEN: process
	begin
		-- CLK1 <= not CLK1 after 50 ps;
		CLK1 <= '0';
		wait for 25 ps;
		CLK1 <= '1';
		wait for 25 ps;
	end process CLKGEN;

STIMULI: process
begin
	RESET1 <= '0', '1' after 825 ps, '0' after 875 ps;
	ENABLE1 <= '0', '1' after 75 ps, '0' after 850 ps, '1' after 900 ps;
	D1 <= '0', '1' after 150 ps, '0' after 250 ps, '1' after 330 ps, '0' after 380 ps, '1' after 600 ps, '0' after 850 ps;
	wait;
	end process STIMULI;

C1: DFF_R_EN port map(CLK1, RESET1, ENABLE1, D1, Q1);
end VERHALTEN;
