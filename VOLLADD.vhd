entity VOLLADD is
	port( AI, BI, CIN: in bit;
	      SI, COUT: out bit);
end VOLLADD;

architecture VERHALTEN of VOLLADD is
begin
	SI <= AI xor BI xor CIN;
	COUT <= (AI and BI) or (CIN and (AI xor BI));
end VERHALTEN;
