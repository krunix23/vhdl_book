entity MUX4X1 is 
	port(	S: in bit_vector(1 downto 0);
		E: in bit_vector(3 downto 0);
		Y: out bit);
end MUX4X1;

architecture VERHALTEN of MUX4X1 is
begin
	with S select -- Auswahlsignal
	Y <=	E(0) when "00",
		E(1) when "01",
		E(2) when "10",
		E(3) when "11";
end VERHALTEN;
