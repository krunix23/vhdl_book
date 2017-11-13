entity IMPULSGEN is
	port(	E: in bit_vector(2 downto 0);
		A: out bit_vector(3 downto 0));
end IMPULSGEN;

architecture TABELLE of IMPULSGEN is
begin
P1: process(E)
	begin
		case E is
			when o"0" => A <= x"7";
			when o"1" => A <= x"A";
			when o"2" => A <= x"3";
			when o"3" => A <= x"F";
			when o"4" => A <= x"6";
			when o"5" => A <= x"C";
			when o"6" => A <= x"0";
			when o"7" => A <= x"E";
		end case;
	end process P1;
end TABELLE;
