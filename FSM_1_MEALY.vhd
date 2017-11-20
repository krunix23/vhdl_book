library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEALY is
	port(	CLK, RESET, ENABLE: in std_logic;
			E: in std_logic_vector(1 downto 0);
			A: out std_logic);
end MEALY;

architecture ARCH1 of MEALY is
type ZUSTAENDE is (Z0, Z1, Z2);
-- Aufzählungstyp
signal ZUSTAND, FOLGEZUSTAND: ZUSTAENDE;
begin
UEBERGANG: process (CLK, RESET)
	begin
	if RESET = '1' then ZUSTAND <= Z0 after 20 ps;
	elsif CLK = '1' and CLK'event then
		if ENABLE = '1' then ZUSTAND <= FOLGEZUSTAND  after 20 ps;
		end if;
	end if;
	end process UEBERGANG;

FOLGEZUSTANDSBERECHNUNG: process(E, ZUSTAND)
begin
	case ZUSTAND is
		when Z0 =>	if E = "01" then FOLGEZUSTAND <= Z1  after 20 ps;
					end if;
		when Z1 =>	if E = "11" then FOLGEZUSTAND <= Z2  after 20 ps;
					elsif E = "01" then FOLGEZUSTAND <= Z1  after 20 ps;
					end if;
		when Z2 =>	if E = "01" then FOLGEZUSTAND <= Z1  after 20 ps;
					end if;
		when others => null;
	end case;
	end process FOLGEZUSTANDSBERECHNUNG;

AUSGABEBERECHNUNG: process(E, ZUSTAND)
begin
	A <= '0' after 20 ps;
	if (ZUSTAND = Z2 and E = "10") then A <= '1' after 20 ps;
	end if;
end process AUSGABEBERECHNUNG;
end ARCH1;
