library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TEST_B_1_ME is
end TEST_B_1_ME;

architecture SEQUENZ of TEST_B_1_ME is
signal CLK_I, RESET_I, ENABLE_I, A_I: bit;
signal E_I: bit_vector(1 downto 0);
type ZUSTAENDE is (Z0, Z1, Z2);
signal ZUSTAND, FOLGE_Z: ZUSTAENDE;
begin
Z_SPEICHER: process (CLK_I, RESET_I)
	begin
	if RESET_I = '1' then ZUSTAND <= Z0 after 20 ps;
	elsif CLK_I = '1' and CLK_I'event then
		if ENABLE_I = '1' then ZUSTAND <= FOLGE_Z  after 20 ps;
		end if;
	end if;
	end process Z_SPEICHER;

UE_SN: process(E_I, ZUSTAND)
	begin
	FOLGE_Z <= Z0 after 20 ps;
	case ZUSTAND is
		when Z0 =>	if E_I = "01" then FOLGE_Z <= Z1  after 20 ps;
					end if;
		when Z1 =>	if E_I = "11" then FOLGE_Z <= Z2  after 20 ps;
					elsif E_I = "01" then FOLGE_Z <= Z1  after 20 ps;
					end if;
		when Z2 =>	if E_I = "01" then FOLGE_Z <= Z1  after 20 ps;
					end if;
		when others => null;
	end case;
	end process UE_SN;

AUS_SN: process(E_I, ZUSTAND)
	begin
	A_I <= '0' after 20 ps;
	if (ZUSTAND = Z2 and E_I = "10") then A_I <= '1' after 20 ps;
	end if;
	end process AUS_SN;

CLOCK: process
	begin
	CLK_I <= '0'; wait for 100 ps;
	CLK_I <= '1'; wait for 100 ps;
	end process CLOCK;

ABLAUF: process
	begin
	ENABLE_I <= '1'; RESET_I <= '1'; E_I <= "01"; wait for 270 ps;
					 RESET_I <= '0';			  wait for 100 ps;
									 E_I <= "11"; wait for 200 ps;
									 E_I <= "10"; wait for 40 ps;
									 E_I <= "00"; wait for 60 ps;
									 E_I <= "10"; wait for 130 ps;
									 E_I <= "01"; wait for 200 ps;
	 ENABLE_I <= '0';				 E_I <= "11"; wait for 200 ps;
	 ENABLE_I <= '1';							  wait for 100 ps;
									 E_I <= "10"; wait for 250 ps;
									 E_I <= "11"; wait for 200 ps;
									 E_I <= "10"; wait for 250 ps;
	end process ABLAUF;
end SEQUENZ;
