-- Impulsfolgenerkennung (01, 11, 10): Moore-Automat
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MOORE is
port(
	CLK:	in std_logic; -- Systemtakt
	RESET:	in std_logic; -- asynchroner Reset (alles auf Null)
	ENABLE:	in std_logic; -- Übergangsaktivierung
	E:		in std_logic_vector(1 downto 0); -- Eingabe
	A:	out std_logic); -- Ausgabebit: 1 wenn Folge erkannt
end MOORE;

architecture ARCH1 of MOORE is
type ZUSTAENDE is (Z0, Z1, Z2, Z3); -- Aufzählungstyp
signal ZUSTAND, FOLGEZUSTAND: ZUSTAENDE;
begin
ZUSTANDSUEBERGANG: process (CLK, RESET)
	begin
	if RESET = '1' then ZUSTAND <= Z0;
	elsif CLK = '1' and CLK'event then
		if ENABLE = '1' then ZUSTAND <= FOLGEZUSTAND;
		end if;
	end if;
end process ZUSTANDSUEBERGANG;

ZUSTANDSBERECHNUNG: process (E, ZUSTAND)
	begin
	case ZUSTAND is
		when Z0 => if E="01" then FOLGEZUSTAND <= Z1 after 20 ps;
			else FOLGEZUSTAND <= Z0 after 20 ps;
			end if;
		when Z1 => if E="11" then FOLGEZUSTAND <= Z2  after 20 ps;
			elsif E="01" then FOLGEZUSTAND <= Z1 after 20 ps;
			else FOLGEZUSTAND <= Z0  after 20 ps;
			end if;
		when Z2 => if E="10" then FOLGEZUSTAND <= Z3 after 20 ps;
			elsif E="01" then FOLGEZUSTAND <= Z1 after 20 ps;
			else FOLGEZUSTAND <= Z0 after 20 ps;
			end if;
		when Z3 => if E="01" then FOLGEZUSTAND <= Z1 after 20 ps;
			else FOLGEZUSTAND <= Z0 after 20 ps;
			end if;
	end case;
	end process ZUSTANDSBERECHNUNG;

AUSGABE: process (ZUSTAND)
begin
	case ZUSTAND is
		when Z3		=> A <= '1' after 20 ps;
		when others	=> A <= '0' after 20 ps;
	end case;
	end process AUSGABE;
end ARCH1;
