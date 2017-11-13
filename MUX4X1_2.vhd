entity MUX4X1_2 is
	port(	S: in bit_vector(1 downto 0);
		E: in bit_vector(3 downto 0);
		Y: out bit);
end MUX4X1_2;

architecture VERHALTEN of MUX4X1_2 is
begin
MUCPROC: process(S, E)
	begin
		case S is
			when "00" => Y <= E(0);
			when "01" => Y <= E(1);
			when "10" => Y <= E(2);
			when "11" => Y <= E(3);
		end case;
	end process MUCPROC;
end VERHALTEN;
