library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM_2nn is
	port(	RESET, CLK	: in bit;
			E			: in bit_vector(1 downto 0);
			A			: out bit );
end FSM_2nn;

architecture SEQUENZ of FSM_2nn is
type ZUSTAENDE is (Z0, Z1, Z2, Z3);
signal ZUSTAND, FOLGE_Z: ZUSTAENDE;
begin
Z_SPEICHER: process (CLK, RESET)
	begin
		if RESET = '1'					then ZUSTAND <= Z0;
		elsif CLK ='1' and CLK'event 	then ZUSTAND <= FOLGE_Z;
		end if;
	end process Z_SPEICHER;
	
UE_AUS_SN: process(E, ZUSTAND)
	begin
	A <= '0';
	FOLGE_Z <= Z0;
	case ZUSTAND is
		when Z0 =>	if E = "01" then FOLGE_Z <= Z1;
					end if;
		when Z1 =>	if E = "11" then FOLGE_Z <= Z2;
					elsif E = "01" then FOLGE_Z <= Z1;
					end if;
		when Z2 =>	if E = "10" then FOLGE_Z <= Z3;
					elsif E = "01" then FOLGE_Z <= Z1;
					end if;
		when Z3 =>	A <= '1';
					if E = "01" then FOLGE_Z <= Z1;
					end if;
	end case;
	end process UE_AUS_SN;
end SEQUENZ;
