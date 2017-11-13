entity PRIORITAETS_ENCODER is
	port(	A, B, X: in bit;
		S: in bit_vector(1 downto 0);
		Y: out bit);
end PRIORITAETS_ENCODER;

architecture VERHALTEN of PRIORITAETS_ENCODER is
begin
P1: process(S, A, B, X)
	begin
		if S(0) = '1' then
			Y <= A and B;
		elsif S(1) = '1' then
			Y <= A or B;
		elsif (S = "00" and X = '1') then
			Y <= A xor B;
		else
			Y <= '0';
		end if;
	end  process P1;
end VERHALTEN;
