library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VECTOR_ADD is
	generic( BITS: natural := 4 );
	port(	A_IN, B_IN: in bit_vector(4 downto 0);
			OP, C_IN: in bit;
			SUM: out bit_vector(4 downto 0);
			OV, C_B: out bit);
end VECTOR_ADD;

architecture ARCH1 of VECTOR_ADD is
signal CIN: bit_vector(0 downto 0);
begin
CIN(0) <= C_IN;
ADD_SUB: process(OP, CIN(0), A_IN, B_IN)
	variable ZW, V1, V2, V3: signed(4 downto 0);
	variable TEMP: signed(2 downto 0);
	begin
	V1 := signed(To_StdLogicVector(A_IN(4 downto 0)));
	V2 := signed(To_StdLogicVector(B_IN(4 downto 0)));
	V3 := "0000" & signed(To_StdLogicVector(CIN));
	if OP = '1' then
		ZW := V1 + V2 + V3;
		TEMP := (ZW(4), V2(4), V1(4));
		case TEMP is
			when "001" => C_B <= '1'; OV <= '0';
			when "010" => C_B <= '1'; OV <= '0';
			when "011" => C_B <= '0'; OV <= '1';
			when "100" => C_B <= '1'; OV <= '1';
			when "111" => C_B <= '1'; OV <= '0';
			when others => C_B <= '0'; OV <= '0';
		end case;
	else
		ZW := V1 - V2 - V3;
		TEMP := (ZW(4), V2(4), V1(4));
		case TEMP is
			when "001" => C_B <= '1'; OV <= '1';
			when "010" => C_B <= '1'; OV <= '0';
			when "100" => C_B <= '1'; OV <= '0';
			when "110" => C_B <= '0'; OV <= '1';
			when "111" => C_B <= '1'; OV <= '0';
			when others => C_B <= '0'; OV <= '0';
		end case;
	end if;
	SUM <= To_BitVector(std_logic_vector(ZW));
	end process ADD_SUB;
end ARCH1;
