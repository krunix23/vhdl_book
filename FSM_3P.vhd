library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM_3P is
	port(	CLK, RESET: in bit;
			E: in bit_vector(1 downto 0);
			A_S: out bit);
end FSM_3P;

architecture SEQUENZ of FSM_3P is
type ZUSTAENDE is (Z0, Z1, Z2, Z3);
signal ZUSTAND, FOLGE_Z: ZUSTAENDE;
signal E_S: bit_vector(1 downto 0);
signal A: bit;
begin
SYNC: process (CLK, RESET)
	begin
	if RESET = '1' then
		E_S <= (others => '0') after 20 ps;
		A_S <= '0' after 20 ps;
	elsif CLK = '1' and CLK'event then
		E_S <= E after 20 ps;
		A_S <= A after 20 ps;
	end if;
	end process SYNC;

Z_SPEICHER: process(CLK, RESET)
	begin
		if RESET = '1' then ZUSTAND <= Z0 after 20 ps;
		elsif CLK = '1' and CLK'event then ZUSTAND <= FOLGE_Z after 20 ps;
		end if;
	end process Z_SPEICHER;

UE_AUS_SN: process(E_S, ZUSTAND)
begin
	A <= '0' after 20 ps; FOLGE_Z <= Z0 after 20 ps;
	case ZUSTAND is
		when Z0 =>	if E_S = "01" then FOLGE_Z <= Z1  after 20 ps;
					end if;
		when Z1 =>	if E_S = "11" then FOLGE_Z <= Z2  after 20 ps;
					elsif E_S = "01" then FOLGE_Z <= Z1  after 20 ps;
					end if;
		when Z2 =>	if E_S = "10" then FOLGE_Z <= Z3  after 20 ps;
					elsif E_S = "01" then FOLGE_Z <= Z1  after 20 ps;
					end if;
		when Z3 =>	A <= '1' after 20 ps;
					if E_S = "01" then FOLGE_Z <= Z1 after 20 ps;
					end if;
	end case;
	end process UE_AUS_SN;
end SEQUENZ;
