entity VOLLADD_TAB is
	port(	CIN, AI, BI: in bit;
		SI, COUT: out bit);
end VOLLADD_TAB;

architecture VERHALTEN of VOLLADD_TAB is
begin
P1: process(CIN, AI, BI)
	variable TEMP_IN: bit_vector(2 downto 0);
	variable TEMP_OUT: bit_vector(1 downto 0);
	begin
		TEMP_IN := CIN & AI & BI;
		case TEMP_IN is
			when "000" => TEMP_OUT := "00";
			when "011" | "101" | "110" => TEMP_OUT := "10";
			when "111" => TEMP_OUT := "11";
			when others => TEMP_OUT := "01";
		end case;
		SI <= TEMP_OUT(0);
		COUT <= TEMP_OUT(1);
	end process P1;
end VERHALTEN;
