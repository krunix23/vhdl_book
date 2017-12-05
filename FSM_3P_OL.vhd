library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM_3P_OL is
	port(	CLK, RESET: in bit;
			E: in bit_vector(1 downto 0);
			A: out bit);
end FSM_3P_OL;

architecture SEQUENZ of FSM_3P_OL is
type ZUSTAENDE is (Z0, Z1, Z2, Z3);
signal ZUSTAND, FOLGE_Z: ZUSTAENDE;
signal E_S: bit_vector(1 downto 0);
begin
SYNC_A: process (CLK, RESET)
	begin
	if RESET = '1' then
		E_S <= (others => '0'); A <= '0';
	elsif CLK = '1' and CLK'event then
		E_S <= E;
		A <= '0';
		case FOLGE_Z is
            when Z3 =>      A <= '1';
            when others =>  null;
        end case;
	end if;
	end process SYNC_A;

Z_SPEICHER: process(CLK, RESET)
	begin
		if RESET = '1' then ZUSTAND <= Z0;
		elsif CLK = '1' and CLK'event then
            ZUSTAND <= FOLGE_Z;
		end if;
	end process Z_SPEICHER;

UE_AUS_SN: process(E_S, ZUSTAND)
begin
	FOLGE_Z <= Z0;
	case ZUSTAND is
		when Z0 =>	if E_S = "01" then FOLGE_Z <= Z1;
					end if;
		when Z1 =>	if E_S = "11" then FOLGE_Z <= Z2;
					elsif E_S = "01" then FOLGE_Z <= Z1;
					end if;
		when Z2 =>	if E_S = "10" then FOLGE_Z <= Z3;
					elsif E_S = "01" then FOLGE_Z <= Z1;
					end if;
		when Z3 =>	if E_S = "01" then FOLGE_Z <= Z1;
					end if;
	end case;
	end process UE_AUS_SN;
end SEQUENZ;
